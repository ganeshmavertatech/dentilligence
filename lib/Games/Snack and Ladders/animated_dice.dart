import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedDice extends StatefulWidget {
  final int value;
  final bool isRolling;
  final double size;
  final Color primaryColor;
  final Color accentColor;

  const AnimatedDice({
    Key? key,
    required this.value,
    required this.isRolling,
    this.size = 80,
    this.primaryColor = Colors.white, // Changed default to white
    this.accentColor = Colors.black87, // Changed dots to dark color
  }) : super(key: key);

  @override
  _AnimatedDiceState createState() => _AnimatedDiceState();
}

class _AnimatedDiceState extends State<AnimatedDice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<int> _randomValues;
  int _displayValue = 1;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _displayValue = widget.value;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Generate random sequence for animation
    _randomValues = List.generate(10, (_) => _random.nextInt(6) + 1);
  }

  @override
  void didUpdateWidget(AnimatedDice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRolling && !oldWidget.isRolling) {
      _rollDice();
    }
    if (widget.value != oldWidget.value && !widget.isRolling) {
      _displayValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rollDice() {
    // Generate new random values for animation
    _randomValues = List.generate(10, (_) => _random.nextInt(6) + 1);

    _controller.reset();
    _controller.forward();

    _controller.addListener(() {
      // Change displayed value during animation
      if (_controller.value < 0.8) {
        final index = (_controller.value * 10).floor();
        if (index < _randomValues.length) {
          setState(() => _displayValue = _randomValues[index]);
        }
      } else {
        // Show final value at end of animation
        setState(() => _displayValue = widget.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.isRolling
              ? _animation.value * 2 * math.pi
              : 0, // Reduced rotation
          child: Transform.scale(
            scale: widget.isRolling
                ? 1.0 +
                    0.1 * math.sin(_animation.value * math.pi) // Reduced bounce
                : 1.0,
            child: _buildDice(),
          ),
        );
      },
    );
  }

  Widget _buildDice() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.primaryColor,
        borderRadius: BorderRadius.circular(
            widget.size * 0.15), // Slightly reduced corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey[50]!,
            Colors.grey[100]!,
          ],
          stops: [0.2, 0.6, 0.9],
        ),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.5,
        ),
      ),
      child: _buildDiceFace(_displayValue),
    );
  }

  Widget _buildDiceFace(int value) {
    // Dot positioning patterns for dice faces
    Map<int, List<Alignment>> dotPositions = {
      1: [Alignment.center],
      2: [Alignment.topRight, Alignment.bottomLeft],
      3: [Alignment.topRight, Alignment.center, Alignment.bottomLeft],
      4: [
        Alignment.topLeft,
        Alignment.topRight,
        Alignment.bottomLeft,
        Alignment.bottomRight
      ],
      5: [
        Alignment.topLeft,
        Alignment.topRight,
        Alignment.center,
        Alignment.bottomLeft,
        Alignment.bottomRight
      ],
      6: [
        Alignment.topLeft,
        Alignment.topRight,
        Alignment.centerLeft,
        Alignment.centerRight,
        Alignment.bottomLeft,
        Alignment.bottomRight
      ],
    };

    final dots = dotPositions[value.clamp(1, 6)] ?? dotPositions[1]!;

    return Stack(
      children: dots.map((alignment) {
        return Align(
          alignment: alignment,
          child: Container(
            width: widget.size * 0.15, // Slightly smaller dots
            height: widget.size * 0.15,
            margin: EdgeInsets.all(widget.size * 0.15),
            decoration: BoxDecoration(
              color: widget.accentColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Helper extensions for color manipulation
extension ColorExtension on Color {
  Color lighten([int amount = 10]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount / 100).clamp(0, 1))
        .toColor();
  }

  Color darken([int amount = 10]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount / 100).clamp(0, 1))
        .toColor();
  }
}
