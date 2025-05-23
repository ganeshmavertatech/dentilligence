import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final List<String> _problemOptions = [
    'General dental advise',
    'Braces, aligners etc - Orthodontists',
    'Gum health and associated issues - Periodontist',
    'Child care - Paedodontists',
    'Crowns, Bridges, Implants',
    'Others',
  ];
  final Set<String> _selectedProblems = {};

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/Images/iconamoon_close-light.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      'Get consultation ready',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 40.h),
                
                // Reason for consultation
                Text(
                  'Reason for consultation',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2A2A2A),
                  ),
                ),
                
                SizedBox(height: 12.h),
                
                // Text input field
                Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0x8F8F8FB2),
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: TextField(
                      controller: _reasonController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your reason',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF909090),
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 30.h),
                
                // Attachment section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attachment',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        'Optional',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFF909090),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12.h),
                
                // Upload area
                GestureDetector(
                  onTap: () {
                    // Handle file upload
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(11, 26, 194, 255),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: const Color(0xFF469BFF),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 19.w),
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF2A2A2A),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 19.w),
                          child: Image.asset(
                            'assets/Images/solar_upload-linear.png',
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 40.h),
                
                // List your problem title
                Text(
                  'List your problem',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2A2A2A),
                  ),
                ),
                
                SizedBox(height: 15.h),
                
                // Problem options
                Column(
                  children: _problemOptions.map((problem) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _buildProblemOption(problem),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: 40.h),
                
                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit
                      print('Selected problems: $_selectedProblems');
                      print('Reason: ${_reasonController.text}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF469BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProblemOption(String problem) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedProblems.contains(problem)) {
            _selectedProblems.remove(problem);
          } else {
            _selectedProblems.add(problem);
          }
        });
      },
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: const Color(0xFFEDEDED).withOpacity(0.4),
        ),
        child: Row(
          children: [
            SizedBox(width: 12.w),
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: _selectedProblems.contains(problem)
                      ? const Color(0xFF469BFF)
                      : const Color(0xFF909090),
                ),
              ),
              child: _selectedProblems.contains(problem)
                  ? Icon(
                      Icons.check,
                      size: 12.sp,
                      color: const Color(0xFF469BFF),
                    )
                  : null,
            ),
            SizedBox(width: 9.w),
            Expanded(
              child: Text(
                problem,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF2A2A2A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}