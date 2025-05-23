import 'dart:math';

import 'package:dentilligence/Games/Snack%20and%20Ladders/new.dart';
import 'package:dentilligence/Games/new_game.dart';
import 'package:dentilligence/Games/space_shooter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GameHubScreen extends StatelessWidget {
  const GameHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Hub')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SpaceShooterScreen()),
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(42, 202, 234, 1),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Space Shooter",
            style: GoogleFonts.gluten(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
         ElevatedButton(
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageGames()),
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(42, 202, 234, 1),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "PackMan",
            style: GoogleFonts.gluten(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
         ElevatedButton(
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePageGame()),  //PlayerScreen()
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(42, 202, 234, 1),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Snake and Ladders",
            style: GoogleFonts.gluten(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
          
           
          ],
        ),
      ),
    );
  }
}

/// Classic Snake Game Implementation


class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

enum Direction {
  up(Offset(0, -1)),
  down(Offset(0, 1)),
  left(Offset(-1, 0)),
  right(Offset(1, 0));

  final Offset offset;
  const Direction(this.offset);
}

class _SnakeGameScreenState extends State<SnakeGameScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // Game state
  List<Offset> snake = [];
  Offset food = Offset.zero;
  Direction direction = Direction.up;
  Direction nextDirection = Direction.up;
  bool gameOver = false;
  int score = 0;
  
  // Game settings
  final int gridSize = 20;
  late double cellSize;
  final double gameSpeed = 0.15;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (gameSpeed * 1000).round()),
    )..addListener(_updateGame);
    _resetGame();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetGame() {
    setState(() {
      gameOver = false;
      score = 0;
      snake = [
        Offset((gridSize ~/ 2).toDouble(), (gridSize ~/ 2).toDouble()),
      ];
      direction = Direction.up;
      nextDirection = Direction.up;
      _placeFood();
      _controller.repeat();
    });
  }

  void _placeFood() {
    final random = Random();
    Offset newFood;
    do {
      newFood = Offset(
        random.nextInt(gridSize).toDouble(),
        random.nextInt(gridSize).toDouble(),
      );
    } while (snake.contains(newFood));
    food = newFood;
  }

  void _updateGame() {
    if (!mounted || gameOver) return;
    
    setState(() {
      direction = nextDirection;
      
      // Calculate new head position
      Offset newHead = Offset(
        (snake.first.dx + direction.offset.dx) % gridSize,
        (snake.first.dy + direction.offset.dy) % gridSize,
      );
      
      // Check for collisions with self
      if (snake.contains(newHead)) {
        gameOver = true;
        _controller.stop();
        return;
      }
      
      // Add new head
      snake.insert(0, newHead);
      
      // Check if snake ate food
      if (newHead == food) {
        score++;
        _placeFood();
      } else {
        // Remove tail if no food eaten
        snake.removeLast();
      }
    });
  }

  void _handleDirection(Direction newDirection) {
    // Prevent 180-degree turns
    if (direction.offset.dx == 0 && newDirection.offset.dx != 0) {
      nextDirection = newDirection;
    } else if (direction.offset.dy == 0 && newDirection.offset.dy != 0) {
      nextDirection = newDirection;
    }
  }

  @override
  Widget build(BuildContext context) {
    cellSize = MediaQuery.of(context).size.width / gridSize;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake Game - Score: $score'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  _handleDirection(Direction.down);
                } else {
                  _handleDirection(Direction.up);
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  _handleDirection(Direction.right);
                } else {
                  _handleDirection(Direction.left);
                }
              },
              child: Container(
                color: Colors.black,
                child: CustomPaint(
                  painter: _SnakePainter(
                    snake: snake,
                    food: food,
                    cellSize: cellSize,
                    gameOver: gameOver,
                  ),
                ),
              ),
            ),
          ),
          if (gameOver)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Play Again'),
              ),
            ),
        ],
      ),
    );
  }
}

class _SnakePainter extends CustomPainter {
  final List<Offset> snake;
  final Offset food;
  final double cellSize;
  final bool gameOver;

  _SnakePainter({
    required this.snake,
    required this.food,
    required this.cellSize,
    required this.gameOver,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw food
    final foodPaint = Paint()..color = Colors.red;
    canvas.drawRect(
      Rect.fromLTWH(
        food.dx * cellSize,
        food.dy * cellSize,
        cellSize,
        cellSize,
      ),
      foodPaint,
    );
    
    // Draw snake
    final snakePaint = Paint()..color = Colors.green;
    for (final segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.dx * cellSize,
          segment.dy * cellSize,
          cellSize,
          cellSize,
        ),
        snakePaint,
      );
    }
    
    // Draw head
    final headPaint = Paint()..color = Colors.lightGreen;
    canvas.drawRect(
      Rect.fromLTWH(
        snake.first.dx * cellSize,
        snake.first.dy * cellSize,
        cellSize,
        cellSize,
      ),
      headPaint,
    );
    
    // Game over overlay
    if (gameOver) {
      final overlayPaint = Paint()
        ..color = Colors.black.withOpacity(0.7);
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        overlayPaint,
      );
      
      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'GAME OVER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      
      textPainter.paint(
        canvas,
        Offset(
          (size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
