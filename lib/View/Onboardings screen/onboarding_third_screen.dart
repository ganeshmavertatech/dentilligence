import 'package:dentilligence/View/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize screenutil
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content column
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Illustration
                  SizedBox(
                    height: 370.h,
                    child: Center(
                      child: _buildIllustration(),
                    ),
                  ),
                  SizedBox(height: 60.h),

                  // Page indicator dots
                  _buildPageIndicators(),
                  SizedBox(height: 24.h),

                  // Title text
                  Text(
                    AppLocalizations.of(context)!.meetups,
                    style: GoogleFonts.corben(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2A2A2A),
                      fontSize: 22.sp,
                      letterSpacing: 0.88,
                      height: 32.h / 22.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Description text
                  Text(
                    AppLocalizations.of(context)!.meetBook,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF959595),
                      fontSize: 14.sp,
                      height: 20.h / 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Get Started button
                  SizedBox(
                    width: 330.w,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF469BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.getStarted,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Sign Up button
                  SizedBox(
                    width: 330.w,
                    height: 56.h,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: const Color(0xFF469BFF),
                          width: 1.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF469BFF),
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 5.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: const Color(0xFF469BFF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(2.5.r),
          ),
        ),
        SizedBox(width: 7.w),
        Container(
          width: 5.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: const Color(0xFF469BFF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(2.5.r),
          ),
        ),
        SizedBox(width: 7.w),
        Container(
          width: 40.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: const Color(0xFF469BFF),
            borderRadius: BorderRadius.circular(2.5.r),
          ),
        ),
      ],
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 271.w,
      height: 370.h,
      child: Stack(
        children: [
          // Main illustration components
          Positioned(
            top: 59.h,
            left: 0,
            child: SizedBox(
              width: 271.w,
              height: 311.h,
              child: Stack(
                children: [
                  // Frame with all the vector images
                  Positioned(
                    top: 70.h,
                    left: 6.w,
                    child: SizedBox(
                      width: 265.w,
                      height: 239.h,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/Images/Frame 2.png',
                            width: 265.w,
                            height: 329.h,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Gray line at bottom
                  Positioned(
                    top: 308.h,
                    left: 0,
                    child: Container(
                      width: 232.w,
                      height: 3.h,
                      color: const Color(0xFFB1B1B1),
                    ),
                  ),

                  // Right circle
                  Positioned(
                    top: 0,
                    left: 188.w,
                    child: Container(
                      width: 76.w,
                      height: 76.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(38.r),
                        border: Border.all(
                          color: const Color(0xFFEDF5FF),
                          width: 6.w,
                        ),
                      ),
                    ),
                  ),

                  // Left circle
                  Positioned(
                    top: 16.h,
                    left: 3.w,
                    child: Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.r),
                        border: Border.all(
                          color: const Color(0xFFEDF5FF),
                          width: 6.w,
                        ),
                      ),
                    ),
                  ),

                  // Mingcute icon
                  Positioned(
                    top: 35.h,
                    left: 24.w,
                    child: Transform.rotate(
                      angle: 16.74 * (3.141592653589793 / 180),
                      child: SizedBox(
                        width: 32.w,
                        height: 32.h,
                        child: Transform.rotate(
                          angle: -16.74 * (3.141592653589793 / 180),
                          child: Image.asset(
                            'assets/Images/notification.png',
                            width: 31.w,
                            height: 35.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Calendar icon
                  Positioned(
                    top: 17.h,
                    left: 205.w,
                    child: Image.asset(
                      'assets/Images/calender.png',
                      width: 41.w,
                      height: 41.h,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center circle with checkmark
          Positioned(
            top: 0,
            left: 85.w,
            child: Container(
              width: 97.w,
              height: 97.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(48.5.r),
                border: Border.all(
                  color: const Color(0xFFFFFAEC),
                  width: 6.w,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/Images/verified.png',
                  width: 65.w,
                  height: 65.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}