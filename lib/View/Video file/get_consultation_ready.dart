import 'package:dentilligence/View/Video%20file/after_all_data_taken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetConsultationPage extends StatefulWidget {
  const GetConsultationPage({super.key});

  @override
  State<GetConsultationPage> createState() => _GetConsultationPageState();
}

class _GetConsultationPageState extends State<GetConsultationPage> {
  String? selectedMouthCondition;
  String? selectedSmokingOption;
  final TextEditingController _xRayController = TextEditingController();

  @override
  void dispose() {
    _xRayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient Information',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Mouth Condition
                        _buildQuestionContainer(
                          title:
                              'Q. How do you rate the condition of your \nmouth?',
                          child: Column(
                            children: ['Good', 'Bad', 'Normal', 'Excellent']
                                .map(
                                  (option) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedMouthCondition = option;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      decoration: BoxDecoration(
                                        color: selectedMouthCondition == option
                                            ? const Color(0xFF469BFF)
                                                .withOpacity(0.2)
                                            : const Color(0xFFEDEDED)
                                                .withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        border: selectedMouthCondition == option
                                            ? Border.all(
                                                color: const Color(0xFF469BFF),
                                                width: 1.w,
                                              )
                                            : null,
                                      ),
                                      width: double.infinity,
                                      height: 40.h,
                                      padding: EdgeInsets.only(left: 15.w),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            option,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xFF2A2A2A),
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// X-ray Question
                        _buildQuestionContainer(
                          title:
                              'Q. What was the last time you had your\nX rays taken?',
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDEDED).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: TextField(
                              controller: _xRayController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write your answer',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF909090),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// Smoking Question
                        _buildQuestionContainer(
                          title: 'Q. Do you smoke?',
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  _buildRadioOption('No'),
                                  SizedBox(width: 10.w),
                                  _buildRadioOption('Yes'),
                                  SizedBox(width: 10.w),
                                  _buildRadioOption('Once a month'),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 100.h), // Space for the bottom button
                      ],
                    ),
                  ),
                ),

                /// Submit Button
                Container(
                  width: double.infinity,
                  height: 90.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50.r,
                        offset: Offset(0, 6.h),
                        color: const Color(0x0F000000),
                      ),
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedMouthCondition == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please select mouth condition',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          );
                          return;
                        }
                        // Navigate to FindingsPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FindingsPage()),
                        );
                      },
                      child: Container(
                        width: 350.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF469BFF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            'Submit & Get results',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionContainer(
      {required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2A2A2A),
            ),
          ),
          SizedBox(height: 15.h),
          child,
        ],
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedSmokingOption,
          onChanged: (val) {
            setState(() {
              selectedSmokingOption = val;
            });
          },
          activeColor: const Color(0xFF469BFF),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF2A2A2A),
          ),
        ),
      ],
    );
  }
}
