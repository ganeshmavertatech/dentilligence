import 'dart:math';

import 'package:flutter/material.dart';

class FlappyBirdScreen extends StatefulWidget {
  const FlappyBirdScreen({super.key});

  @override
  State<FlappyBirdScreen> createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Game variables
  double birdY = 0.5; // 0-1 scale (0 = top, 1 = bottom)
  double birdWidth = 0.1; // Relative to screen width
  double birdHeight = 0.1; // Relative to screen height
  double gravity = 0.001; // Gravity strength
  double velocity = 0; // Current velocity
  double jumpStrength = -0.015; // Jump strength
  double pipeWidth = 0.15; // Relative to screen width
  List<double> pipeHeights = []; // 0-1 scale for gap center
  List<double> pipeX = []; // 0-1 scale (1 = right edge)
  double pipeGap = 0.3; // Gap size (relative to screen height)
  double pipeSpeed = 0.005; // Pipe movement speed
  double pipeSpawnRate = 2.0; // Seconds between pipes
  double pipeTimer = 0;
  int score = 0;
  bool gameOver = false;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60 FPS
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
      birdY = 0.5;
      velocity = 0;
      pipeHeights = [];
      pipeX = [];
      score = 0;
      gameOver = false;
      _controller.repeat();
    });
  }

  void _jump() {
    if (!gameOver) {
      setState(() => velocity = jumpStrength);
    } else {
      _resetGame();
    }
  }

  void _updateGame() {
    if (!mounted || gameOver) return;

    setState(() {
      // Apply physics
      velocity += gravity;
      birdY += velocity;

      // Check boundaries
      if (birdY > 1 - birdHeight/2 || birdY < birdHeight/2) {
        gameOver = true;
        _controller.stop();
        return;
      }

      // Spawn pipes
      pipeTimer += 16/1000;
      if (pipeTimer >= pipeSpawnRate) {
        pipeTimer = 0;
        pipeHeights.add(0.2 + Random().nextDouble() * 0.6);
        pipeX.add(1.0);
      }

      // Move pipes and check collisions
      for (int i = 0; i < pipeX.length; i++) {
        pipeX[i] -= pipeSpeed;

        // Score point when passing a pipe
        if (pipeX[i] + pipeWidth < 0.5 && pipeX[i] + pipeWidth + pipeSpeed >= 0.5) {
          score++;
        }

        // Collision detection
        if (pipeX[i] < 0.5 + birdWidth/2 && 
            pipeX[i] + pipeWidth > 0.5 - birdWidth/2) {
          double gapTop = pipeHeights[i] - pipeGap/2;
          double gapBottom = pipeHeights[i] + pipeGap/2;
          
          if (birdY - birdHeight/2 < gapTop || 
              birdY + birdHeight/2 > gapBottom) {
            gameOver = true;
            _controller.stop();
            return;
          }
        }
      }

      // Remove off-screen pipes
      while (pipeX.isNotEmpty && pipeX.first + pipeWidth < 0) {
        pipeX.removeAt(0);
        pipeHeights.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Flappy Bird - Score: $score'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: _jump,
        child: Container(
          color: Colors.lightBlue[100],
          child: CustomPaint(
            painter: _FlappyBirdPainter(
              birdY: birdY,
              birdSize: birdHeight * screenSize.height,
              pipeX: pipeX,
              pipeHeights: pipeHeights,
              pipeWidth: pipeWidth * screenSize.width,
              pipeGap: pipeGap * screenSize.height,
              gameOver: gameOver,
              score: score,
              screenSize: screenSize,
            ),
          ),
        ),
      ),
    );
  }
}

class _FlappyBirdPainter extends CustomPainter {
  final double birdY;
  final double birdSize;
  final List<double> pipeX;
  final List<double> pipeHeights;
  final double pipeWidth;
  final double pipeGap;
  final bool gameOver;
  final int score;
  final Size screenSize;

  _FlappyBirdPainter({
    required this.birdY,
    required this.birdSize,
    required this.pipeX,
    required this.pipeHeights,
    required this.pipeWidth,
    required this.pipeGap,
    required this.gameOver,
    required this.score,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw bird
    final birdPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(
      Offset(size.width / 2, birdY * size.height),
      birdSize / 2,
      birdPaint,
    );

    // Draw pipes
    final pipePaint = Paint()..color = Colors.green;
    for (int i = 0; i < pipeX.length; i++) {
      // Top pipe
      canvas.drawRect(
        Rect.fromLTWH(
          pipeX[i] * size.width,
          0,
          pipeWidth,
          (pipeHeights[i] - pipeGap/2) * size.height,
        ),
        pipePaint,
      );

      // Bottom pipe
      canvas.drawRect(
        Rect.fromLTWH(
          pipeX[i] * size.width,
          (pipeHeights[i] + pipeGap/2) * size.height,
          pipeWidth,
          size.height,
        ),
        pipePaint,
      );
    }

    // Draw score
    final scoreText = TextPainter(
      text: TextSpan(
        text: '$score',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    scoreText.paint(
      canvas,
      Offset((size.width - scoreText.width) / 2, size.height * 0.2),
    );

    // Game over overlay
    if (gameOver) {
      final overlay = Paint()..color = Colors.black54;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        overlay,
      );

      final gameOverText = TextPainter(
        text: const TextSpan(
          text: 'GAME OVER\nTap to restart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);

      gameOverText.paint(
        canvas,
        Offset((size.width - gameOverText.width) / 2, 
               (size.height - gameOverText.height) / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}