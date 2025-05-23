import 'package:dentilligence/View/Search/consultation_ready.dart';
import 'package:dentilligence/View/Search/pay_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      backgroundColor: const Color(0xFF469BFF),
      body: Stack(
        children: [
          // Confirmation illustration
          Positioned(
            top: 100.h,
            left: 88.w,
            child: Image.asset(
              'assets/Images/succeful.png',
              width: 212.w,
              height: 157.h,
            ),
          ),

          // "Booking Confirmed" title
          Positioned(
            top: 300.h,
            left: 77.w,
            child: Text(
              AppLocalizations.of(context)!.bookingConfirmed,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 32.sp,
                height: 1.0,
              ),
            ),
          ),

          // Confirmation message
          Positioned(
            top: 350.h,
            left: 84.w,
            child: SizedBox(
              width: 234.w,
              child: Text(
                AppLocalizations.of(context)!.appointmentConfirmed,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16.sp,
                  height: 1.25,
                ),
              ),
            ),
          ),

          // Booking details card
          Positioned(
            top: 460.h,
            left: 20.w,
            child: Container(
              width: 350.w,
              height: 316.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(30.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Booking Details title
                    Text(
                      'Booking Details',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2A2A),
                        fontSize: 20.sp,
                        height: 0.9,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // Doctor info row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor image
                        Container(
                          width: 45.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                8.r), // Added border radius
                            image: const DecorationImage(
                              image: AssetImage('assets/Images/female_dr.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        // Doctor details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. Ritu Bose',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2A2A2A),
                                fontSize: 18.sp,
                                height: 0.89,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // Rating and location row
                            Row(
                              children: [
                                // Rating
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFC83B),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 10.sp,
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        '5.0',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w),

                                // Dot separator
                                Container(
                                  width: 4.w,
                                  height: 4.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF909090),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 5.w),

                                // Location
                                Text(
                                  'London',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF909090),
                                    fontSize: 14.sp,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(width: 5.w),

                                // Dot separator
                                Container(
                                  width: 4.w,
                                  height: 4.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF909090),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 5.w),

                                // Distance
                                Text(
                                  '15km away',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF909090),
                                    fontSize: 14.sp,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    // Divider
                    Divider(
                      color: const Color(0xFFEDEDED),
                      thickness: 1.h,
                    ),
                    SizedBox(height: 15.h),

                    // Appointment time
                    Text(
                      'In-Clinic Appointment time',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2A2A2A),
                        fontSize: 14.sp,
                        height: 1.29,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Date and time
                    Row(
                      children: [
                        Image.asset(
                          'assets/Images/mynaui_calendar.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Friday, 16 May on 12:15 PM',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF469BFF),
                            fontSize: 16.sp,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // View Booking button
                    SizedBox(
                      width: 290.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ConsultationScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF469BFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.getConsultationReady,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
