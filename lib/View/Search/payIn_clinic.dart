import 'package:dentilligence/View/Search/confirm_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayInClinicScreen extends StatefulWidget {
  const PayInClinicScreen({super.key});

  @override
  State<PayInClinicScreen> createState() => _PayInClinicScreenState();
}

class _PayInClinicScreenState extends State<PayInClinicScreen> {
  bool isChecked = false;
  bool payOnlineSelected = false; // Add this to track payment mode

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18.h),

                    // Header with back button and title
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/Images/arrow_back.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Image.asset(
                          'assets/Images/clinic_icon.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          AppLocalizations.of(context)!.bookInClinicAppointment,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2A2A2A),
                            fontSize: 20.sp,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 33.h),

                    // Doctor profile section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            'assets/Images/doctor1.png',
                            width: 120.w,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20.w),
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
                                height: 1.33,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Dentist, Orthodontics, Dental surgeon',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF909090),
                                fontSize: 12.sp,
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
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
                                  SizedBox(width: 4.w),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '\$50 ' + 
                                  AppLocalizations.of(context)!.fees,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2A2A2A),
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // Appointment time card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xFF469BFF).withOpacity(0.05),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .appointmentTime,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2A2A2A),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: const Color(0xFF469BFF),
                                size: 20.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                'Friday, 16 May on 12:15 PM',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF469BFF),
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 29.h),

                    // Clinic address section
                    Text(
                      AppLocalizations.of(context)!
                          .clinicAddress,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2A2A),
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: const Color(0xFF2A2A2A),
                          size: 20.sp,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            '2.4mi, 80 Ridgeway road, Sheffield, S12 2SX',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF909090),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward,
                          color: const Color(0xFF2A2A2A),
                          size: 20.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // Payment mode selection
                    Text(
                      AppLocalizations.of(context)!
                          .modeOfPayment,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2A2A),
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFEDEDED),
                          width: 1.w,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    payOnlineSelected = false;
                                  });
                                },
                                child: Icon(
                                  payOnlineSelected
                                      ? Icons.radio_button_unchecked
                                      : Icons.radio_button_checked,
                                  color: payOnlineSelected
                                      ? const Color(0xFF909090)
                                      : const Color(0xFF469BFF),
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                AppLocalizations.of(context)!
                                    .payAtClinic,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: payOnlineSelected
                                      ? FontWeight.w400
                                      : FontWeight.w700,
                                  color: const Color(0xFF2A2A2A),
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 68.w),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    payOnlineSelected = true;
                                  });
                                },
                                child: Icon(
                                  payOnlineSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: payOnlineSelected
                                      ? const Color(0xFF469BFF)
                                      : const Color(0xFF909090),
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                AppLocalizations.of(context)!
                                    .payOnline,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: payOnlineSelected
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: const Color(0xFF2A2A2A),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          if (payOnlineSelected) ...[
                            SizedBox(height: 12.h),
                            Text(
                               AppLocalizations.of(context)!
                                    .freeCancellation +' 15 May 11:30 PM',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF2A2A2A),
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'T & C*',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF2A2A2A),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 41.h),

                    // Bill details
                    Text(
                      AppLocalizations.of(context)!
                          .billDetails,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2A2A),
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .consultationFees,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF909090),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '\$50',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF2A2A2A),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .taxFree,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF909090),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\$2 ',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF2A2A2A),
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: 'FREE',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF189958),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 19.h),
                    Divider(),
                    SizedBox(height: 19.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: isChecked
                                  ? const Color(0xFFFFC83B)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: isChecked
                                    ? const Color(0xFFFFC83B)
                                    : const Color(0xFF909090),
                                width: 1.w,
                              ),
                            ),
                            child: isChecked
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12.sp,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!
                                .iamAware,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF2A2A2A),
                              fontSize: 14.sp,
                              height: 1.28,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Spacer for bottom button
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),

            // Bottom button bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90.h,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 50,
                      offset: const Offset(0, -6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 90.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: const Color(0xFFEDEDED),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '\$52',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2A2A2A),
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 13.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isChecked) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BookingConfirmedScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please confirm you are aware of the cancellation policy.'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF469BFF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .confirmVisit,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
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
