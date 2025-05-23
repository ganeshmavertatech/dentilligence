import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindingsPage extends StatelessWidget {
  const FindingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize screen util
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    
                    // Title
                    Text(
                      'Findings',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    
                    SizedBox(height: 26.h),
                    
                    // Image and health metrics row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left placeholder rectangle
                        Container(
                          width: 120.w,
                          height: 160.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        
                        SizedBox(width: 20.w),
                        
                        // Health metrics column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHealthMetric(
                                title: 'Tooth health',
                                score: '90/100',
                                progress: 0.9,
                              ),
                              SizedBox(height: 32.h),
                              _buildHealthMetric(
                                title: 'Gum health',
                                score: '70/100',
                                progress: 0.7,
                              ),
                              SizedBox(height: 32.h),
                              _buildHealthMetric(
                                title: 'Smile Characteristics',
                                score: '50/100',
                                progress: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Risk assessment title
                    Text(
                      'Risk assessment',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Bottom rectangle
                    Container(
                      width: double.infinity,
                      height: 397.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFEDEDED),
                        ),
                      ),
                      // Add your risk assessment content here
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Thank you button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF469BFF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Thank you!',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF469BFF),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHealthMetric({
    required String title,
    required String score,
    required double progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Text(
              score,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8.h),
        
        // Progress bar
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xFF909090).withOpacity(0.1),
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            Container(
              width: 200.w * progress,
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFC83B),
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ],
        ),
      ],
    );
  }
}