import 'package:dentilligence/View/Login/login_page.dart';
import 'package:dentilligence/View/Onboardings%20screen/onboarding_second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 390,
          height: 844,
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Container(
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                width: 390,
                height: 844,
                child: Container(
                  color: const Color(0x1A469BFF), // 10% opacity blue
                ),
              ),

              // Gradient rectangle
              Positioned(
                top: 0,
                left: 90,
                child: Container(
                  width: 210,
                  height: 468,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFEDF5FF),
                        Color(0x33469BFF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Decorative Circles
              Positioned(
                top: 77,
                left: 147,
                child: _buildEllipseWithImage(
                  size: 97,
                  imageUrl: 'assets/Images/screen_2.png',
                ),
              ),
              Positioned(
                top: 136,
                left: 250,
                child: _buildEllipseWithImage(
                  size: 97,
                  imageUrl: 'assets/Images/screen_1.png',
                ),
              ),
              Positioned(
                top: 149,
                left: 55,
                child: _buildEllipseWithImage(
                  size: 97,
                  imageUrl: 'assets/Images/screen_3.png',
                ),
              ),

              // Doctor illustration (resized)
              Positioned(
                top: 250,
                left: 120,
                child: SizedBox(
                  width: 150, // reduced from 161
                  height: 220, // reduced from 243
                  child: Image.asset(
                    'assets/Images/booking-plan-bottom1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Page indicator
              Positioned(
                top: 496,
                left: 168,
                child: Row(
                  children: [
                    _buildIndicatorDot(isActive: true),
                    const SizedBox(width: 2),
                    _buildIndicatorDot(isActive: false),
                    const SizedBox(width: 2),
                    _buildIndicatorDot(isActive: false),
                  ],
                ),
              ),

              // Header
               Positioned(
                top: 527,
                left: 30,
                child: Text(
                  AppLocalizations.of(context)!.book,
                  style: GoogleFonts.corben(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2A2A2A),
                    height: 1.45,
                  ),
                ),
              ),

              // Subheader
              Positioned(
                top: 606,
                left: 30,
                child: Text(
                  AppLocalizations.of(context)!.find,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Color(0xFF959595),
                    height: 1.4,
                  ),
                ),
              ),

             
                 Positioned(
                bottom: 40,
                left: 30,
               child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder:(context) => SignInScreen()));
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
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder:(context)=>OnboardingScreenTwo()));
                  },
                  child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF469BFF),
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
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method for image inside a circle
  Widget _buildEllipseWithImage({
    required double size,
    required String imageUrl,
    double padding = 8.0,
  }) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFEDF5FF),
          width: 6,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 60,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Indicator dots
  Widget _buildIndicatorDot({required bool isActive}) {
    return Container(
      width: isActive ? 40 : 5,
      height: 5,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF469BFF)
            : const Color(0x80469BFF),
        borderRadius: BorderRadius.circular(2.5),
      ),
    );
  }
}