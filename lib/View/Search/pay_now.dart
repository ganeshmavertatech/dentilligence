import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentNowPage extends StatefulWidget {
  const PaymentNowPage({super.key});

  @override
  State<PaymentNowPage> createState() => _PaymentNowPageState();
}

class _PaymentNowPageState extends State<PaymentNowPage> {
  String selectedPaymentMethod = 'upi'; // 'upi', 'google_pay', 'phone_pay', 'card'
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  void _launchUPIApp(String app) async {
    final uri = Uri.parse(app == 'google_pay' 
        ? 'tez://upi/pay?pa=merchant@upi&pn=MERCHANT&mc=1234&tr=123456789&tn=Payment&am=100&cu=INR'
        : 'phonepe://pay?pa=merchant@upi&pn=MERCHANT&mc=1234&tr=123456789&tn=Payment&am=100&cu=INR');
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch ${app == 'google_pay' ? 'Google Pay' : 'PhonePe'}')),
      );
    }
  }

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
              
              // Trusted Platform Banner
              Container(
                width: double.infinity,
                height: 62.h,
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF189958).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF189958),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      '100% Trusted & Secure Platform',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF189958),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // UPI Payment Option
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = 'upi';
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFEDEDED)),
                  ),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'upi',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: const Color(0xFF469BFF),
                      ),
                      SizedBox(width: 10.w),
                      Image.asset(
                        'assets/Images/upi-icon.png', // Your UPI icon
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'UPI',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // UPI Payment Options (shown only when UPI is selected)
              if (selectedPaymentMethod == 'upi') ...[
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFEDEDED)),
                  ),
                  child: Column(
                    children: [
                      // Google Pay Option
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 'google_pay';
                          });
                          _launchUPIApp('google_pay');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/Images/google-pay-icon 1.png',
                                width: 24.w,
                                height: 24.h,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Google Pay',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 1.h, color: const Color(0xFFEDEDED)),
                      
                      // PhonePe Option
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 'phone_pay';
                          });
                          _launchUPIApp('phone_pay');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/Images/phonepe-icon 1.png',
                                width: 24.w,
                                height: 24.h,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'PhonePe',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 20.h),

              // Credit/Debit Card Option
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = 'card';
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFEDEDED)),
                  ),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'card',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: const Color(0xFF469BFF),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.credit_card,
                        size: 24.sp,
                        color: selectedPaymentMethod == 'card' 
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFF909090),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Credit / Debit Card',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: selectedPaymentMethod == 'card' 
                              ? FontWeight.w600 
                              : FontWeight.w400,
                          color: selectedPaymentMethod == 'card'
                              ? const Color(0xFF2A2A2A)
                              : const Color(0xFF909090),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Card Details (shown only when card is selected)
              if (selectedPaymentMethod == 'card') ...[
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFEDEDED)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Number',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2A2A2A),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 46.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF919191).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: TextField(
                          controller: _cardNumberController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(color: Color(0xFF919191)),
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry date',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2A2A2A),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 46.h,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF919191).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: TextField(
                                    controller: _expiryController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'MM/YY',
                                      hintStyle: TextStyle(color: Color(0xFF919191)),
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF2A2A2A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CVV',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2A2A2A),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 46.h,
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF919191).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: TextField(
                                    controller: _cvvController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'XXX',
                                      hintStyle: TextStyle(color: Color(0xFF919191)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF2A2A2A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // Pay Now Button inside card details
                      ElevatedButton(
                        onPressed: () {
                          if (_cardNumberController.text.isEmpty || 
                              _expiryController.text.isEmpty || 
                              _cvvController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill all card details')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Payment processed successfully')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF469BFF),
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
}