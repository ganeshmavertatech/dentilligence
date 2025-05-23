import 'dart:async';

import 'package:dentilligence/Bottom%20Bar/bottom_navigation_bar.dart' as custom_nav;
import 'package:flutter/material.dart';

class RegisteredScreen extends StatefulWidget {
  const RegisteredScreen({super.key});

  @override
  State<RegisteredScreen> createState() => _RegisteredScreenState();
}

class _RegisteredScreenState extends State<RegisteredScreen> {
 double screenWidth = 0;
  double screenHeight = 0;
  int countdown = 2;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        _navigateToHomePage();
      }
    });
  }

  void _navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => custom_nav.NavigationBar()),
                      (route) => false,
                    );
    
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          child: Stack(
            children: [
              // Blue rectangle background
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 390,
                  height: 844,
                  color: Color(0xFF469BFF),
                ),
              ),

              // Faint Ellipses (background decorations)
              Positioned(
                top: -77,
                left: -304,
                child: Container(
                  width: 998,
                  height: 998,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                top: -12,
                left: -239,
                child: Container(
                  width: 868,
                  height: 868,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2A5D99).withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                top: 103,
                left: -124,
                child: Container(
                  width: 638,
                  height: 638,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                top: 185,
                left: -42,
                child: Container(
                  width: 474,
                  height: 474,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),

              // Decorative Symbols
              Positioned(
                top: 350,
                left: 90,
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Positioned(
                top: 300,
                right: 90,
                child: Text(
                  '○',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Positioned(
                top: 250,
                left: 170,
                child: Text(
                  '△',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Positioned(
                top: 400,
                right: 100,
                child: Text(
                  '×',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),

              // Success Icon (concentric circles)
              Positioned(
                top: 300,
                left: 138,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Icons/verified.png',
                          width: 66,
                          height: 66,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // "Successful!" text
              Positioned(
                top: 450,
                left: 90,
                child: Image.asset('assets/Images/Successful!.png',height: 32,width: 230,)
              ),

              // Description text
              Positioned(
                top: 500,
                left: 40,
                right: 40,
                child: Text(
                  'Your account successfully created, now you\nbook doctors and enjoy the games.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lato', // Ensure the font is added in pubspec.yaml
                    color: Colors.white.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
              ),

              // Login Button
              Positioned(
                bottom: 20,
                left: 30,
                right: 30,
                child: GestureDetector(
                  onTap: ()=>_navigateToHomePage(),
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInScreen()),
                    //   (route) => false,
                    // );
                  // },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                        color: Color(0xFF469BFF),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}