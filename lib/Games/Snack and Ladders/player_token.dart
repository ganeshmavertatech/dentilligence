import 'package:flutter/material.dart';

class PlayerToken extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final String? playerName;

  const PlayerToken({
    Key? key,
    this.size = 35,
    this.color = Colors.red,
    this.borderColor = Colors.white,
    this.playerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main player token
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
            gradient: RadialGradient(
              colors: [
                color.withOpacity(0.8),
                color,
                color.withOpacity(0.7),
              ],
              stops: [0.0, 0.5, 1.0],
              center: Alignment(0.0, 0.0),
            ),
          ),
          child: Center(
            child: Container(
              width: size * 0.4,
              height: size * 0.4,
              decoration: BoxDecoration(
                color: Colors.white30,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // Optional player name label
        if (playerName != null)
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              playerName!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

// // Alternative player token designs can be created by extending PlayerToken class
// class AnimalPlayerToken extends PlayerToken {
//   final String animalType; // 'monkey', 'elephant', 'tiger', etc.

//   const AnimalPlayerToken({
//     Key? key,
//     required this.animalType,
//     double size = 35,
//     Color color = Colors.orange,
//     String? playerName,
//   }) : super(key: key, size: size, color: color, playerName: playerName);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.white, width: 2),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black38,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               _getAnimalEmoji(),
//               style: TextStyle(fontSize: size * 0.5),
//             ),
//           ),
//         ),
//         if (playerName != null)
//           Container(
//             margin: EdgeInsets.only(top: 4),
//             padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//             decoration: BoxDecoration(
//               color: Colors.black54,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(
//               playerName!,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   String _getAnimalEmoji() {
//     switch (animalType.toLowerCase()) {
//       case 'monkey':
//         return '🐵';
//       case 'elephant':
//         return '🐘';
//       case 'tiger':
//         return '🐯';
//       case 'dog':
//         return '🐶';
//       case 'cat':
//         return '🐱';
//       case 'rabbit':
//         return '🐰';
//       default:
//         return '🐵';
//     }
//   }
// }
