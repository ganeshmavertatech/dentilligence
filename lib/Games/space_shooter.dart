import 'dart:math';

import 'package:flutter/material.dart';

enum Difficulty { normal, medium, hard }

class SpaceShooterScreen extends StatefulWidget {
  const SpaceShooterScreen({super.key});

  @override
  State<SpaceShooterScreen> createState() => _SpaceShooterScreenState();
}

class _SpaceShooterScreenState extends State<SpaceShooterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Game State
  bool _gameStarted = false;
  bool _gameOver = false;
  Difficulty? _selectedDifficulty;

  // Stats
  int _smashedCount = 0;
  int _missedEnemies = 0;
  int _maxMissedEnemies = 10;

  // Game Objects
  Offset playerPosition = Offset.zero;
  final List<Offset> bullets = [];
  final List<Offset> enemies = [];
  final Random _random = Random();
  double enemySpawnTimer = 0;
  double enemySpawnRate = 1.0;
  double bulletCooldown = 0;
  double bulletFireRate = 0.2;

  // Player Movement
  double _playerVelocityX = 0;
  final double _friction = 0.85;
  final double _acceleration = 0.8;
  final double _maxSpeed = 12.0;

  // Game Dimensions
  late double screenWidth;
  late double screenHeight;
  final double playerSize = 50;
  final double bulletSize = 25;
  final double enemySize = 50;
  double bulletSpeed = 600;
  double enemySpeed = 300;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateGame);
  }

  void _startGame(Difficulty difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
      _gameStarted = true;
      _gameOver = false;
      _smashedCount = 0;
      _missedEnemies = 0;
      bullets.clear();
      enemies.clear();

      switch (difficulty) {
        case Difficulty.normal:
          enemySpawnRate = 1.0;
          enemySpeed = 300;
          bulletFireRate = 0.2;
          _maxMissedEnemies = 10;
          break;
        case Difficulty.medium:
          enemySpawnRate = 0.7;
          enemySpeed = 400;
          bulletFireRate = 0.15;
          _maxMissedEnemies = 10;
          break;
        case Difficulty.hard:
          enemySpawnRate = 0.4;
          enemySpeed = 500;
          bulletFireRate = 0.1;
          _maxMissedEnemies = 10;
          break;
      }

      _controller.repeat();
    });
  }

  void _endGame() {
    _controller.stop();
    setState(() {
      _gameOver = true;
      _gameStarted = false;
    });
  }

  void _updateGame() {
    if (!_gameStarted || !mounted) return;
    const dt = 16 / 1000;

    setState(() {
      _playerVelocityX *= _friction;
      if (_playerVelocityX.abs() < 0.1) _playerVelocityX = 0;

      playerPosition = Offset(
        (playerPosition.dx + _playerVelocityX).clamp(0, screenWidth - playerSize),
        playerPosition.dy,
      );

      bulletCooldown -= dt;
      if (bulletCooldown <= 0) {
        _shoot();
        bulletCooldown = bulletFireRate;
      }

      bullets.removeWhere((bullet) => bullet.dy < 0);
      for (var i = 0; i < bullets.length; i++) {
        bullets[i] = Offset(bullets[i].dx, bullets[i].dy - bulletSpeed * dt);
      }

      enemies.removeWhere((enemy) {
        if (enemy.dy > screenHeight) {
          _missedEnemies++;
          if (_missedEnemies >= _maxMissedEnemies) {
            _endGame();
          }
          return true;
        }
        return false;
      });

      for (var i = 0; i < enemies.length; i++) {
        enemies[i] = Offset(enemies[i].dx, enemies[i].dy + enemySpeed * dt);
      }

      enemySpawnTimer += dt;
      if (enemySpawnTimer >= enemySpawnRate) {
        enemySpawnTimer = 0;
        enemies.add(Offset(
          _random.nextDouble() * (screenWidth - enemySize),
          -enemySize,
        ));
      }

      _checkCollisions();
    });
  }

  void _checkCollisions() {
    final List<Offset> bulletsToRemove = [];
    final List<Offset> enemiesToRemove = [];

    for (final bullet in bullets) {
      for (final enemy in enemies) {
        if (bullet.dx < enemy.dx + enemySize &&
            bullet.dx + bulletSize > enemy.dx &&
            bullet.dy < enemy.dy + enemySize &&
            bullet.dy + bulletSize > enemy.dy) {
          bulletsToRemove.add(bullet);
          enemiesToRemove.add(enemy);
          _smashedCount++;
          break;
        }
      }
    }

    bullets.removeWhere((bullet) => bulletsToRemove.contains(bullet));
    enemies.removeWhere((enemy) => enemiesToRemove.contains(enemy));
  }

  void _handlePlayerMovement(Offset delta) {
    final directionX = delta.dx.sign;
    _playerVelocityX += directionX * _acceleration;
    _playerVelocityX = _playerVelocityX.clamp(-_maxSpeed, _maxSpeed);
  }

  void _shoot() {
    bullets.add(Offset(
      playerPosition.dx + playerSize / 2 - bulletSize / 2,
      playerPosition.dy - bulletSize,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (playerPosition == Offset.zero) {
      playerPosition = Offset(
        screenWidth / 2 - playerSize / 2,
        screenHeight - playerSize - 100,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Space Shooter')),
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) => _handlePlayerMovement(details.delta),
            onPanEnd: (_) => setState(() => _playerVelocityX *= 0.3),
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  if (_gameStarted)
                    Positioned(
                      left: playerPosition.dx,
                      top: playerPosition.dy,
                      width: playerSize,
                      height: playerSize,
                      child: Image.asset('assets/Images/player.png'),
                    ),
                  ...bullets.map((bullet) => Positioned(
                        left: bullet.dx,
                        top: bullet.dy,
                        width: bulletSize,
                        height: bulletSize,
                        child: Image.asset('assets/Images/enemy00.png'),
                      )),
                  ...enemies.map((enemy) => Positioned(
                        left: enemy.dx,
                        top: enemy.dy,
                        width: enemySize,
                        height: enemySize,
                        child: Image.asset('assets/Images/enemy.png'),
                      )),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      'Teeth Smashed: $_smashedCount',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Text(
                      'Teeth Missed: $_missedEnemies / $_maxMissedEnemies',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Difficulty selection overlay
          if (!_gameStarted && !_gameOver)
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Select Difficulty',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    for (var difficulty in Difficulty.values)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ElevatedButton(
                          onPressed: () => _startGame(difficulty),
                          child: Text(difficulty.name.toUpperCase()),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          // Game over overlay
          if (_gameOver)
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Teeth Smashed: $_smashedCount',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Teeth Missed: $_missedEnemies / $_maxMissedEnemies',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _gameOver = false;
                          _gameStarted = false;
                          bullets.clear();
                          enemies.clear();
                          playerPosition = Offset.zero;
                        });
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
