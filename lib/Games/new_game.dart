import 'dart:async';
import 'dart:math';

import 'package:dentilligence/Games/my_monster.dart';
import 'package:dentilligence/Games/my_path.dart';
import 'package:dentilligence/Games/my_pixel.dart';
import 'package:dentilligence/Games/my_player.dart';
import 'package:flutter/material.dart';


class HomePageGames extends StatefulWidget {
  @override
  _HomePageGamesState createState() => _HomePageGamesState();
}

class _HomePageGamesState extends State<HomePageGames> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  int player = numberInRow * 14 + 1; //pos of player
  bool mouthClosed = false;
  bool ate = true;
  int score = 0;
  List<int> monsters = [];
int monsterSpeed = 500; // milliseconds between moves
bool monsterActive = false;
bool isGameOver = false;
bool isGameStarted = false;
Timer? playerTimer;
Timer? monsterTimer;



// Add this method to initialize monsters
void initMonsters() {
  // Add initial monster positions (avoid player start and barriers)
  monsters.add(numberInRow * 5 + 5); // Example position
}
void moveMonsters() {
  if (isGameOver) return; // Don't move if game is over
  
  setState(() {
    for (int i = 0; i < monsters.length; i++) {
      List<int> possibleMoves = [];
      int current = monsters[i];
      
      // Check possible moves (not through barriers)
      if (!barriers.contains(current - 1)) possibleMoves.add(current - 1);
      if (!barriers.contains(current + 1)) possibleMoves.add(current + 1);
      if (!barriers.contains(current - numberInRow)) possibleMoves.add(current - numberInRow);
      if (!barriers.contains(current + numberInRow)) possibleMoves.add(current + numberInRow);
      
      // Simple AI: move randomly
      if (possibleMoves.isNotEmpty) {
        monsters[i] = possibleMoves[Random().nextInt(possibleMoves.length)];
      }
      
      // Check if monster caught player
      if (monsters[i] == player) {
        gameOver();
      }
    }
  });
}

void gameOver() {
  setState(() {
    isGameOver = true;
    monsterActive = false;
  });
  
  // Cancel all timers
  playerTimer?.cancel();
  monsterTimer?.cancel();
  
  // Show game over dialog
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score'),
          actions: [
            TextButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          ],
        );
      },
    );
  });
}
void resetGame() {
  setState(() {
    player = numberInRow * 14 + 1;
    score = 0;
    isGameOver = false;
    isGameStarted = false;
    food.clear();
    vis.clear();
    monsters.clear();
    direction = "right";
  });
}
  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    24,
    35,
    46,
    26,
    28,
    37,
    38,
    39,
    30,
    41,
    52,
    59,
    70,
    67,
    68,
    69,
    61,
    72,
    73,
    74,
    75,
    100,
    101,
    102,
    103,
    105,
    106,
    107,
    108,
    116,
    123,
    134,
    145,
    114,
    136,
    137,
    138,
    147,
    149,
    129,
    151,
    140,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    76,
    65,
    54,
    43,
    32,
    21
  ];

  List<int> food = [];
  List<int> vis = [];

  String direction = "right";

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  void startGame() {
  if (isGameStarted) return; // Prevent multiple starts
  isGameStarted = true;
  
  getFood();
  initMonsters();
  monsterActive = true;
  
  // Player movement timer
  playerTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
    if (isGameOver) {
      timer.cancel();
      return;
    }
    
    setState(() {
      mouthClosed = !mouthClosed;
    });

    if (food.contains(player)) {
      score++;
      food.remove(player);
      vis.add(player);
    }

    switch (direction) {
      case "left": moveLeft(); break;
      case "right": moveRight(); break;
      case "up": moveUp(); break;
      case "down": moveDown(); break;
    }
  });
  
  // Monster movement timer (slower than player)
  monsterTimer = Timer.periodic(Duration(milliseconds: monsterSpeed), (timer) {
    if (isGameOver) {
      timer.cancel();
      return;
    }
    if (monsterActive) {
      moveMonsters();
    }
  });
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      children: [
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              GestureDetector(
                onVerticalDragUpdate: isGameOver ? null : (details) {
                  if (details.delta.dy > 0) direction = "down";
                  else if (details.delta.dy < 0) direction = "up";
                },
                onHorizontalDragUpdate: isGameOver ? null : (details) {
                  if (details.delta.dx > 0) direction = "right";
                  else if (details.delta.dx < 0) direction = "left";
                },
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numberInRow,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (isGameOver && player == index) {
                        return Center(
                          child: Icon(Icons.close, color: Colors.red, size: 30),
                        );
                      }
                      if (mouthClosed && player == index) {
                        return Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[400], 
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      } 
                      else if (player == index) {
                        switch (direction) {
                          case "left": return Transform.rotate(angle: pi, child: MyPlayer());
                          case "right": return MyPlayer();
                          case "up": return Transform.rotate(angle: 3 * pi / 2, child: MyPlayer());
                          case "down": return Transform.rotate(angle: pi / 2, child: MyPlayer());
                          default: return MyPlayer();
                        }
                      } 
                      else if (monsters.contains(index)) {
                        return MyMonster();
                      }
                      else if (barriers.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.blue[800],
                          outerColor: Colors.blue[900],
                        );
                      } 
                      else if (!barriers.contains(index) && vis.contains(index)) {
                        return MyPath(
                          innerColor: Colors.black,
                          outerColor: Colors.black,
                        );
                      }
                      else {
                        return MyPath(
                          innerColor: Colors.yellow[400],
                          outerColor: Colors.black,
                        );
                      }
                    },
                  ),
                ),
              ),
              if (isGameOver) // This is the full-screen GAME OVER overlay
                Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Text(
                      'GAME OVER',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Score "+ score.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                GestureDetector(
                  onTap: isGameOver ? resetGame : startGame,
                  child: Text(
                    isGameOver ? "RESTART" : "PLAY",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}