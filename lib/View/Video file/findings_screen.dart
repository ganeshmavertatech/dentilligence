import 'package:dentilligence/View/Video%20file/findings_screen_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindingsScreen extends StatelessWidget {
  const FindingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.findings,
                    style: GoogleFonts.lato(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  AppLocalizations.of(context)!.whyPhotos,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2A2A2A),
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0x8F8F8FB2),
                      width: 0.5.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gray boxes row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _grayBox('assets/Images/Group (5).png'),
                          _grayBox('assets/Images/Frame.png'),
                          _grayBox('assets/Images/Frame (1).png'),
                        ],
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        AppLocalizations.of(context)!.concerns,
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2A2A2A),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _iconTextRow(
                        text:
                            AppLocalizations.of(context)!.helpsDentist,
                      ),
                      SizedBox(height: 12.h),
                      _iconTextRow(
                        text:
                            AppLocalizations.of(context)!.helpsReport,
                      ),
                      SizedBox(height: 12.h),
                      _iconTextRow(
                        text:
                            AppLocalizations.of(context)!.helpsPreview,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context)!.howItWorks,
                  style: GoogleFonts.lato(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF469BFF),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF469BFF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FindingsScreenTwo()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.startNow,
                      style: GoogleFonts.lato(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _grayBox(String imagePath) {
    return Container(
      width: 96.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(45, 255, 199, 59), // Yellow background
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          width: 45.w,
          height: 45.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _iconTextRow({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18.w,
          height: 18.h,
          decoration: const BoxDecoration(
            color: Color(0xFF469BFF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              'assets/Images/lucide_check.png',
              width: 12.w,
              height: 10.h,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: 14.sp,
              color: const Color(0xFF2A2A2A),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
