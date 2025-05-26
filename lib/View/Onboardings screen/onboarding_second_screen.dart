import 'package:dentilligence/View/Login/login_page.dart';
import 'package:dentilligence/View/Onboardings%20screen/onboarding_third_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 390, // Fixed width as in design
          height: 844, // Fixed height as in design
          child: Stack(
            children: [
              // Background yellow rectangle with opacity
              Positioned.fill(
                child: Container(
                  color: Color(0x1AFFC83B), // #ffc83b with 10% opacity
                ),
              ),

              // Semi-transparent gradient rectangle
              Positioned(
                top: 0,
                left: 90,
                child: Container(
                  width: 210,
                  height: 468,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 250, 236, 0.2),
                        Color.fromRGBO(255, 200, 59, 0.2),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Images
              // Image 1 (Top-left, with tilt and border radius)
              Positioned(
                top: 138,
                left: 38,
                child: Transform.rotate(
                  angle: -0.2, // counter-clockwise
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/Images/game_1.png',
                      width: 99,
                      height: 99,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

// Image 2 (Top-middle, with tilt and border radius)
              Positioned(
                top: 63,
                left: 157,
                child: Transform.rotate(
                  angle: 0.0, // no rotation
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/Images/game_2.png',
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

// Image 3 (Top-right, with tilt and border radius)
              Positioned(
                top: 176,
                left: 252,
                child: Transform.rotate(
                  angle: 0.2, // counter-clockwise
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/Images/game_3.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Middle illustration group
              Positioned(
                top: 238,
                left: 117,
                child: SizedBox(
                  width: 163,
                  height: 236,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/Images/doctor_1.png',
                        width: 163,
                        height: 234,
                      ),

                      // Small ellipses (eyes?)
                      Positioned(
                        top: 41,
                        left: 56,
                        child: Container(
                          width: 10,
                          height: 9,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4B799),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 41,
                        left: 85,
                        child: Container(
                          width: 9,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4B799),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Fun games text
              Positioned(
                top: 527,
                left: 30,
                child: Text(
                  AppLocalizations.of(context)!.fun,
                  style: GoogleFonts.corben(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A2A2A),
                    height: 1.45,
                    letterSpacing: 0.88,
                  ),
                ),
              ),

              // Subtext
              Positioned(
                top: 606,
                left: 30,
                child: Text(
                  AppLocalizations.of(context)!.fundes,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Color(0xFF959595),
                    height: 1.43,
                  ),
                ),
              ),

              // Skip
              Positioned(
                bottom: 40,
                left: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.skip,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 30,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnboardingScreenThree()));
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC83B),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x66469BFF),
                          offset: const Offset(0, 20),
                          blurRadius: 54,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),

              // Page indicator
              Positioned(
                top: 496,
                left: 168,
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color(0x80FFC83B),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    SizedBox(width: 2),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFC83B),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    SizedBox(width: 2),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color(0x80FFC83B),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
