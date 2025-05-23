import 'package:dentilligence/View/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 390,
        height: 844,
        child: Stack(
          children: [
            // Top status bar line
            

            // Page indicator dots
            Positioned(
              top: 496,
              left: 168,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF469BFF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            Positioned(
              top: 496,
              left: 175,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF469BFF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            Positioned(
              top: 496,
              left: 182,
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF469BFF),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),

            // Title text
            Positioned(
              top: 520,
              left: 30,
              child: Text(
                'Meetups at Your \nConvenience',
                style: GoogleFonts.corben(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2A2A2A),
                  fontSize: 22,
                  letterSpacing: 0.88,
                  height: 32 / 22,
                ),
              ),
            ),

            // Description text
            Positioned(
              top: 590,
              left: 30,
              child: Text(
                'Book in-clinic appointments that fit your schedule. \nQuick, easy, and stress-free dental visits — just for you',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF959595),
                  fontSize: 14,
                  height: 20 / 14,
                ),
              ),
            ),

            // Get Started button
            Positioned(
              top: 650,
              left: 30,
              child: GestureDetector(
               onTap: (){
                Navigator.push(context,MaterialPageRoute(builder:(context) => SignInScreen()));
               },
              child:       Container(
                width: 330,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF469BFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              ),
            ),

            // Sign Up button
            Positioned(
              top: 720,
              left: 30,
              child: Container(
                width: 330,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF469BFF),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF469BFF),
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),

            // Complex illustration
            Positioned(
              top: 77,
              left: 62,
              child: SizedBox(
                width: 271,
                height: 370,
                child: Stack(
                  children: [
                    // Main illustration components
                    Positioned(
                      top: 59,
                      left: 0,
                      child: SizedBox(
                        width: 271,
                        height: 311,
                        child: Stack(
                          children: [
                            // Frame with all the vector images
                            Positioned(
                              top: 70,
                              left: 6,
                              child: SizedBox(
                                width: 265,
                                height: 239,
                                child: Stack(
                                  children: [
                                    // All the vector images would go here
                                    // This is simplified - in a real app you'd need to 
                                    // either use the exact images or recreate them with Flutter
                                    Image.asset(
                                      'assets/Images/Frame 2.png',
                                      width: 265,
                                      height: 329,
                                    ),
                                    // Add all other vector images similarly...
                                  ],
                                ),
                              ),
                            ),

                            // Gray line at bottom
                            Positioned(
                              top: 308,
                              left: 0,
                              child: Container(
                                width: 232,
                                height: 3,
                                color: const Color(0xFFB1B1B1),
                              ),
                            ),

                            // Right circle
                            Positioned(
                              top: 0,
                              left: 188,
                              child: Container(
                                width: 76,
                                height: 76,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(38),
                                  border: Border.all(
                                    color: const Color(0xFFEDF5FF),
                                    width: 6,
                                  ),
                                ),
                              ),
                            ),

                            // Left circle
                            Positioned(
                              top: 16,
                              left: 3,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    color: const Color(0xFFEDF5FF),
                                    width: 6,
                                  ),
                                ),
                              ),
                            ),

                            // Mingcute icon
                            Positioned(
                              top: 35,
                              left: 24,
                              child: Transform.rotate(
                                angle: 16.74 * (3.141592653589793 / 180),
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Transform.rotate(
                                    angle: -16.74 * (3.141592653589793 / 180),
                                    child: Image.asset(
                                      'assets/Images/notification.png',
                                      width: 31,
                                      height: 35,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Calendar icon
                            Positioned(
                              top: 17,
                              left: 205,
                              child: Image.asset(
                                'assets/Images/calender.png',
                                width: 41,
                                height: 41,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Center circle with checkmark
                    Positioned(
                      top: 0,
                      left: 85,
                      child: Container(
                        width: 97,
                        height: 97,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(48.5),
                          border: Border.all(
                            color: const Color(0xFFFFFAEC),
                            width: 6,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/Images/verified.png',
                            width: 65,
                            height: 65,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}