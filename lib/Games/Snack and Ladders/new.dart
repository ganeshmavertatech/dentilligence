import 'dart:math';

import 'package:flutter/material.dart';

import 'animated_dice.dart';

class MyHomePageGame extends StatefulWidget {
  @override
  _MyHomePageGameState createState() => _MyHomePageGameState();
}

class _MyHomePageGameState extends State<MyHomePageGame> {
  Color ply1Color = Colors.white;
  int randomNo = 1;
  bool isRolling = false;
  int ply1 = 0;
  int targetPosition = 0;
  bool isMoving = false;
  var boardName1 = 'assets/Images/board.png';
  List<int> movementPath = [];

  // Colors for the board
  final Color lightColor = Colors.amber.shade100; // Yellow
  final Color darkColor = Colors.white; // Orange

  int getDisplayNumber(int gridIndex) {
    int row = 9 - (gridIndex ~/ 10);
    bool isReversed = row % 2 == 1;
    
    if (isReversed) {
      return (row + 1) * 10 - (gridIndex % 10);
    } else {
      return row * 10 + (gridIndex % 10) + 1;
    }
  }

  int positionToGridIndex(int position) {
    int row = 9 - ((position - 1) ~/ 10);
    bool isReversed = row % 2 == 1;
    
    if (isReversed) {
      int col = 9 - ((position - 1) % 10);
      return row * 10 + col;
    } else {
      return row * 10 + ((position - 1) % 10);
    }
  }

  Future<void> animatePlayerMovement(int start, int end) async {
    movementPath = [];
    int current = start;
    
    // Generate movement path
    while (current < end) {
      current++;
      movementPath.add(current);
      if (current >= 100) break;
    }
    
    // Animate through each position
    for (int position in movementPath) {
      setState(() {
        ply1 = position;
      });
      await Future.delayed(Duration(milliseconds: 500));
      
      // Check for snakes/ladders at each step
      int newPosition = snakeLadderCmd(position);
      if (newPosition != position) {
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          ply1 = newPosition;
        });
        break; // Stop movement if hit snake/ladder
      }
    }
    
    // Final position after all movement
    setState(() {
      ply1 = snakeLadderCmd(end);
      isMoving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Snakes & Ladders'),
        // automaticallyImplyLeading: false,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.refresh),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (_) => AlertDialog(
          //         title: Text("Restart Game"),
          //         content: Text("Would you like to restart?"),
          //         actions: [
          //           TextButton(
          //             child: Text('Yes'),
          //             onPressed: () {
          //               setState(() => ply1 = 0);
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           TextButton(
          //             child: Text('No'),
          //             onPressed: () => Navigator.of(context).pop(),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 500,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      GridView.count(
                        crossAxisCount: 10,
                        childAspectRatio: 1.0,
                        children: List.generate(100, (index) {
                          int displayNum = getDisplayNumber(index);
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 0.5),
                              color: ply1 == displayNum
                                  ? Colors.red
                                  : (index + (index ~/ 10)) % 2 == 0
                                      ? lightColor
                                      : darkColor,
                            ),
                            child: Center(
                              child: Text(
                                '$displayNum',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      Image.asset(boardName1, fit: BoxFit.cover),
                      GridView.count(
                        crossAxisCount: 10,
                        childAspectRatio: 1.0,
                        children: List.generate(100, (index) {
                          return Visibility(
                            visible: ply1 == getDisplayNumber(index),
                            child: Center(
                              child: Icon(Icons.person, color: ply1Color, size: 24),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedDice(
              value: randomNo,
              isRolling: isRolling,
              size: 80,
              primaryColor: Colors.white,
              accentColor: Colors.black87,
            ),
            InkWell(
              onTap: () async {
                if (ply1 == 100 || isRolling || isMoving) return;
                
                setState(() {
                  isRolling = true;
                  isMoving = true;
                });
                
                await Future.delayed(Duration(milliseconds: 600));
                
                setState(() {
                  randomNo = Random().nextInt(6) + 1;
                  isRolling = false;
                });
                
                if (ply1 == 0) {
                  setState(() {
                    ply1 = randomNo == 1 ? 1 : 0;
                    isMoving = false;
                  });
                } else if (ply1 + randomNo <= 100) {
                  int newPosition = ply1 + randomNo;
                  await animatePlayerMovement(ply1, newPosition);
                }
                
                if (ply1 == 100) {
                  showWinDialog();
                }
              },
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.casino, color: Colors.white),
                    Text('Roll Dice', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Text('Get 1 to start the game'),
          ],
        ),
      ),
    );
  }

  final Map<int, int> snakes = {
    99: 18,
    90: 48,
    54: 45,
    39: 23,
    33: 14,
    17: 5,
  };

  final Map<int, int> ladders = {
    9: 48,
    41: 59,
    44: 85,
    87: 95,
  };

  int snakeLadderCmd(int pos) {
    if (snakes.containsKey(pos)) {
      print("Snake! $pos -> ${snakes[pos]}");
      return snakes[pos]!;
    } else if (ladders.containsKey(pos)) {
      print("Ladder! $pos -> ${ladders[pos]}");
      return ladders[pos]!;
    }
    return pos;
  }

  void showWinDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("You Won!"),
        content: Text("Congratulations! You reached 100!"),
        actions: [
          TextButton(
            child: Text('Play Again'),
            onPressed: () {
              setState(() => ply1 = 0);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}