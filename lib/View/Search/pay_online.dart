import 'package:dentilligence/View/Search/pay_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Video Consultation',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Doctor Profile
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: const DecorationImage(
                        image: AssetImage('assets/Images/female_dr.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Ritu Bose',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Dentist, Orthodontics, Dental surgeon',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF909090),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC83B),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star,
                                  size: 16.sp, color: Colors.white),
                              SizedBox(width: 4.w),
                              Text(
                                '4.5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '\$50 Fees',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              // Appointment Details
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF469BFF).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Video consultation time',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20.sp,
                          color: const Color(0xFF469BFF),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Friday, 16 May on 12:15 PM',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF469BFF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Text(
                        'Free follow-up for 7 days',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF41B792),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Cancellation Notice
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC83B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Free cancellation until 15 May 11:30 PM',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Text(
                      'T & C*',
                      style: TextStyle(
                        fontSize: 12.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              // Bill Details
              Text(
                'Bill details',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Consultation fees',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF909090),
                    ),
                  ),
                  Text(
                    '\$50',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF909090),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$2',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF909090),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'FREE',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFFFC83B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Divider(height: 1.h, color: const Color(0xFFEDEDED)),
              SizedBox(height: 20.h),

              // Terms Checkbox
              Row(
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
                        ),
                      ),
                      child: isChecked
                          ? Icon(
                              Icons.check,
                              size: 12.sp,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100.h), // Space for the bottom button
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isChecked
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentNowPage()),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isChecked 
                ? const Color(0xFF469BFF)
                : const Color(0xFF469BFF).withOpacity(0.5),
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            'Pay \$50 & Confirm Video Consult',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}