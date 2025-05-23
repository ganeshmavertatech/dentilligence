import 'dart:math';

import 'package:dentilligence/Games/Snack%20and%20Ladders/player_token.dart';
import 'package:flutter/material.dart';



class BoardWidget extends StatelessWidget {
  final int playerPosition;
  final Map<int, int> snakesAndLadders;
  final String theme; // Theme parameter: 'classic', 'jungle', 'space'
  
  // Added image parameter with default null value
  final ImageProvider? backgroundImage;

  const BoardWidget({
    Key? key,
    required this.playerPosition,
    required this.snakesAndLadders,
    this.theme = 'classic',
    this.backgroundImage,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final availableHeight = constraints.maxHeight;
      final availableWidth = constraints.maxWidth;
      final boardSize = min(availableWidth, availableHeight);
      final cellSize = boardSize / 10;
      const tokenSize = 35.0;

      // Ensure the position is within 1 to 100
      int pos = playerPosition.clamp(1, 100);

      // --- Calculate token position on canvas ---
      final boardRow = ((pos - 1) ~/ 10);
      final pixelRow = 9 - boardRow;
      int tokenCol;
      if (boardRow % 2 == 0) {
        tokenCol = (pos - 1) % 10;
      } else {
        tokenCol = 10 - (pos - boardRow * 10);
      }
      final tokenLeft = tokenCol * cellSize + (cellSize - tokenSize) / 2;
      final tokenTop = pixelRow * cellSize + (cellSize - tokenSize) / 2;

      // Theme colors and images
      final Map<String, Map<String, dynamic>> themes = {
        'classic': {
          'background': Colors.brown[50],
          'evenCells': Colors.amber[50],
          'oddCells': Colors.white,
          'boardBorder': Colors.brown[300],
          'cellBorder': Colors.brown[200],
          'snakeColor': Colors.red.shade700,
          'ladderColor': Colors.green.shade700,
          'numberColor': Colors.brown[800],
          'highlightCell': Colors.green[100],
          'backgroundImage': const AssetImage('assets/Images/board.png'),
          'cellOpacity': 0.4,
        },
        // 'jungle': {
        //   'background': Colors.green[50],
        //   'evenCells': Colors.lightGreen[50],
        //   'oddCells': Colors.white,
        //   'boardBorder': Colors.green[700],
        //   'cellBorder': Colors.green[200],
        //   'snakeColor': Colors.orange.shade700,
        //   'ladderColor': Colors.brown.shade700,
        //   'numberColor': Colors.green[800],
        //   'highlightCell': Colors.lime[100],
        //   'backgroundImage': AssetImage('assets/Images/board.png'),
        //   'cellOpacity': 0.4,
        // },
        // 'space': {
        //   'background': Colors.indigo[100],
        //   'evenCells': Colors.deepPurple[50],
        //   'oddCells': Colors.white,
        //   'boardBorder': Colors.indigo[400],
        //   'cellBorder': Colors.indigo[200],
        //   'snakeColor': Colors.pink.shade700,
        //   'ladderColor': Colors.cyan.shade700,
        //   'numberColor': Colors.indigo[800],
        //   'highlightCell': Colors.purple[100],
        //   'backgroundImage': const AssetImage('assets/Images/board.png'),
        //   'cellOpacity': 0.4,
        // },
      };

      
      final themeColors = themes[theme] ?? themes['classic']!;
      
      
      final ImageProvider? themeImage = backgroundImage ?? themeColors['backgroundImage'];

      return Container(
        decoration: BoxDecoration(
          color: themeColors['background'],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: themeColors['boardBorder'],
            width: 3,
          ),
          image: themeImage != null
              ? DecorationImage(
                   
                  image: themeImage,
                  fit: BoxFit.fitWidth,
                  
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // --- Grid of board cells ---
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                ),
                itemCount: 100,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final gridRow = index ~/ 10;
                  final gridCol = index % 10;
                  final cellBoardRow = 9 - gridRow;
                  int number;
                  if (cellBoardRow % 2 == 0) {
                    number = cellBoardRow * 10 + (gridCol + 1);
                  } else {
                    number = cellBoardRow * 10 + (10 - gridCol);
                  }

                  // Apply vibrant alternating pattern
                  final bool isEvenCell = (gridRow + gridCol) % 2 == 0;
                  
                  // Make cell colors semi-transparent to show background image
                  final double opacity = themeColors['cellOpacity'] ?? 0.85;
                  final Color cellColor = (playerPosition == number)
                      ? themeColors['highlightCell'].withOpacity(opacity)
                      : (isEvenCell
                          ? themeColors['evenCells'].withOpacity(opacity)
                          : themeColors['oddCells'].withOpacity(opacity));

                  return Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      border: Border.all(color: themeColors['cellBorder']),
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Special styling for milestone squares
                        if (number % 10 == 0 || number == 1 || number == 100)
                          Container(
                            width: cellSize * 0.7,
                            height: cellSize * 0.7,
                            decoration: BoxDecoration(
                              color: number == 100
                                  ? Colors.amber.withOpacity(0.3)
                                  : (number == 1
                                      ? Colors.green.withOpacity(0.3)
                                      : Colors.blue.withOpacity(0.2)),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(
                          number.toString(),
                          style: TextStyle(
                            color: themeColors['numberColor'],
                            fontWeight:
                                number % 10 == 0 || number == 1 || number == 100
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            fontSize:
                                number % 10 == 0 || number == 1 || number == 100
                                    ? 16
                                    : 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // --- Custom painting for snakes and ladders ---
              CustomPaint(
                size: Size(boardSize, boardSize),
                painter: SnakesAndLaddersPainter(
                  snakesAndLadders: snakesAndLadders,
                  boardSize: Size(boardSize, boardSize),
                  snakeColor: themeColors['snakeColor'],
                  ladderColor: themeColors['ladderColor'],
                ),
              ),

              // --- Player token with shadow effect ---
              if (playerPosition >= 1 && playerPosition <= 100)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  left: tokenLeft,
                  top: tokenTop,
                  child: const PlayerToken(
                    size: tokenSize,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class SnakesAndLaddersPainter extends CustomPainter {
  final Map<int, int> snakesAndLadders;
  final Size boardSize;
  final Color snakeColor;
  final Color ladderColor;

  SnakesAndLaddersPainter({
    required this.snakesAndLadders,
    required this.boardSize,
    this.snakeColor = Colors.red,
    this.ladderColor = Colors.green,
  });

  /// Returns the center position (in canvas coordinates) for a given board position.
  (double, double) _calculatePosition(int position) {
    final cellWidth = boardSize.width / 10;
    final cellHeight = boardSize.height / 10;
    final boardRow = ((position - 1) ~/ 10);
    final pixelRow = 9 - boardRow;
    int col;
    if (boardRow % 2 == 0) {
      col = (position - 1) % 10;
    } else {
      col = 10 - (position - boardRow * 10);
    }
    final centerX = col * cellWidth + cellWidth / 2;
    final centerY = pixelRow * cellHeight + cellHeight / 2;
    return (centerX, centerY);
  }

  @override
  void paint(Canvas canvas, Size size) {
    snakesAndLadders.forEach((start, end) {
      final (startX, startY) = _calculatePosition(start);
      final (endX, endY) = _calculatePosition(end);
      final isLadder = end > start;

      if (isLadder) {
        _drawLadder(canvas, startX, startY, endX, endY);
      } else {
        _drawSnake(canvas, startX, startY, endX, endY);
      }
    });
  }

  void _drawLadder(
      Canvas canvas, double startX, double startY, double endX, double endY) {
    final ladderPaint = Paint()
      ..color = ladderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Add shadow for depth
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);

    const offset = 6.0;

    // Draw shadow first
    canvas.drawLine(
      Offset(startX - offset + 1, startY + 1),
      Offset(endX - offset + 1, endY + 1),
      shadowPaint,
    );
    canvas.drawLine(
      Offset(startX + offset + 1, startY + 1),
      Offset(endX + offset + 1, endY + 1),
      shadowPaint,
    );

    // Draw ladder rails
    canvas.drawLine(
      Offset(startX - offset, startY),
      Offset(endX - offset, endY),
      ladderPaint,
    );
    canvas.drawLine(
      Offset(startX + offset, startY),
      Offset(endX + offset, endY),
      ladderPaint,
    );

    final distance = sqrt(pow(endX - startX, 2) + pow(endY - startY, 2));
    final steps = (distance / 30).round() + 1;
    final stepPaint = Paint()
      ..color = ladderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < steps; i++) {
      final t = i / (steps - 1);
      final x1 = startX - offset + (endX - startX - offset) * t;
      final y1 = startY + (endY - startY) * t;
      final x2 = startX + offset + (endX - startX + offset) * t;
      final y2 = y1;

      // Draw shadow
      canvas.drawLine(
          Offset(x1 + 1, y1 + 1), Offset(x2 + 1, y2 + 1), shadowPaint);

      // Draw step
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), stepPaint);
    }
  }

  void _drawSnake(
      Canvas canvas, double startX, double startY, double endX, double endY) {
    final snakePaint = Paint()
      ..color = snakeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Shadow paint
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);

    final path = Path();
    path.moveTo(startX, startY);

    // Create a more sinuous snake path with multiple control points
    final controlPoints = <Offset>[];
    final segmentCount = 4; // Number of curve segments

    for (int i = 0; i <= segmentCount; i++) {
      final t = i / segmentCount;
      final x = startX + (endX - startX) * t;
      final y = startY + (endY - startY) * t;

      // Add some randomized waviness to the snake
      final waviness = 25.0;
      final waveOffset = (i % 2 == 0) ? waviness : -waviness;

      controlPoints.add(Offset(x + waveOffset, y));
    }

    // Replace start and end with exact points
    controlPoints[0] = Offset(startX, startY);
    controlPoints[segmentCount] = Offset(endX, endY);

    // Draw the snake path with multiple cubic curves
    path.moveTo(controlPoints[0].dx, controlPoints[0].dy);

    for (int i = 0; i < segmentCount; i++) {
      final startPoint = controlPoints[i];
      final endPoint = controlPoints[i + 1];

      // Calculate control points for smooth curve
      final controlX1 = startPoint.dx + (endPoint.dx - startPoint.dx) / 3;
      final controlY1 = startPoint.dy + (endPoint.dy - startPoint.dy) / 3;

      final controlX2 = startPoint.dx + 2 * (endPoint.dx - startPoint.dx) / 3;
      final controlY2 = startPoint.dy + 2 * (endPoint.dy - startPoint.dy) / 3;

      path.cubicTo(
          controlX1, controlY1, controlX2, controlY2, endPoint.dx, endPoint.dy);
    }

    // Draw shadow first
    canvas.drawPath(path, shadowPaint);

    // Then draw the snake
    canvas.drawPath(path, snakePaint);

    // Draw snake head
    final headPaint = Paint()
      ..color = snakeColor
      ..style = PaintingStyle.fill;

    // Draw eyes
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(endX, endY), 8, headPaint);

    // Calculate eye positions based on the direction
    final angle = atan2(endY - controlPoints[segmentCount - 1].dy,
        endX - controlPoints[segmentCount - 1].dx);

    final eyeOffset = 3.0;
    final eyeX1 = endX + cos(angle + 0.5) * eyeOffset;
    final eyeY1 = endY + sin(angle + 0.5) * eyeOffset;
    final eyeX2 = endX + cos(angle - 0.5) * eyeOffset;
    final eyeY2 = endY + sin(angle - 0.5) * eyeOffset;

    // Draw eyes
    canvas.drawCircle(Offset(eyeX1, eyeY1), 2, eyePaint);
    canvas.drawCircle(Offset(eyeX2, eyeY2), 2, eyePaint);
    canvas.drawCircle(Offset(eyeX1, eyeY1), 1, pupilPaint);
    canvas.drawCircle(Offset(eyeX2, eyeY2), 1, pupilPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
