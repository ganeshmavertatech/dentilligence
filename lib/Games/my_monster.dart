import 'package:flutter/material.dart';

class MyMonster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.6),
      child: Image.asset(
        'assets/Images/ghost.png' // Your monster image path
      ),
    );
  }
}