// import 'dart:math';

// import 'package:dentilligence/Games/Snack%20and%20Ladders/SnakesAndLaddersModel.dart';
// import 'package:dentilligence/Games/Snack%20and%20Ladders/animated_dice.dart';
// import 'package:dentilligence/Games/Snack%20and%20Ladders/board_dice.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PlayerScreen extends StatefulWidget {
//   @override
//   _PlayerScreenState createState() => _PlayerScreenState();
// }

// class _PlayerScreenState extends State<PlayerScreen>
//     with SingleTickerProviderStateMixin {
//   int _currentPosition = 0;
//   final Random _random = Random();
//   bool isRolling = false;
//   int diceValue = 1;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _rollDice() {
//     if (!isRolling) {
//       setState(() {
//         isRolling = true;
//       });

//       // Delay to allow dice animation to complete
//       Future.delayed(Duration(milliseconds: 600), () {
//         setState(() {
//           diceValue = _random.nextInt(6) + 1;
//           _movePlayer(diceValue);
//           isRolling = false;
//         });
//       });
//     }
//   }

//   void _checkGameOver() {
//     if (_currentPosition >= 100) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Congratulations! 🎉'),
//             content: const Text('You won the game!'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   _resetGame();
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Play Again'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   _resetGame();
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                 },
//                 child: const Text('Back to Menu'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void _resetGame() {
//     setState(() {
//       _currentPosition = 0;
//       diceValue = 1;
//       isRolling = false;
//     });
//   }

//   void _movePlayer(int diceRoll) {
//     final model = Provider.of<SnakesAndLaddersModel>(context, listen: false);
//     final allSnakesAndLadders = {...model.snakes, ...model.ladders};

//     setState(() {
//       isRolling = true;
//       Future.delayed(Duration(milliseconds: 500), () {
//         setState(() {
//           _currentPosition += diceRoll;
//           if (_currentPosition >= 100) {
//             _currentPosition = 100;
//             _checkGameOver();
//           } else if (allSnakesAndLadders.containsKey(_currentPosition)) {
//             Future.delayed(Duration(milliseconds: 600), () {
//               setState(() {
//                 _currentPosition = allSnakesAndLadders[_currentPosition]!;
//               });
//             });
//           }
//           isRolling = false;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final model = Provider.of<SnakesAndLaddersModel>(context);
//     final allSnakesAndLadders = {...model.snakes, ...model.ladders};

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text('Player Mode'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _resetGame,
//             tooltip: 'Reset Game',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Game board takes up 70% of the screen
//           Expanded(
//             flex: 7,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: BoardWidget(
//                 playerPosition: _currentPosition,
//                 snakesAndLadders: allSnakesAndLadders,
//               ),
//             ),
//           ),
//           // Divider to separate board from controls
//           Divider(height: 1, thickness: 1, color: Colors.grey[300]),
//           // Controls section takes up 30% of the screen
//           Expanded(
//             flex: 3,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue[50],
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 12),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     'Current Position: $_currentPosition',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   AnimatedDice(
//                     value: diceValue,
//                     isRolling: isRolling,
//                     size: 80,
//                     primaryColor: Colors.white,
//                     accentColor: Colors.black87,
//                   ),
//                   ElevatedButton(
//                     onPressed: isRolling ? null : _rollDice,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[600],
//                       foregroundColor: Colors.white,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 3,
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.casino, size: 20),
//                         SizedBox(width: 8),
//                         Text(
//                           isRolling ? 'Rolling...' : 'Roll Dice',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
