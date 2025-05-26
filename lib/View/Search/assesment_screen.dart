import 'package:dentilligence/View/Search/dentist_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Make sure this import path is correct
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  String? _pressingProblem;
  String? _doctorSeeking;
  String? _doctorSpecialization;
  String? _visitUrgency;
  String? _insuranceCoverage;

  bool get isContinueEnabled =>
      _pressingProblem != null &&
      _doctorSeeking != null &&
      _doctorSpecialization != null &&
      _visitUrgency != null &&
      _insuranceCoverage != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 20.w,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/Images/iconamoon_close-light.png',
                width: 24.w,
                height: 24.h,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              AppLocalizations.of(context)!.assessment,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: const Color(0xFF2A2A2A),
              ),
            ),
          ],
        ),
      backgroundColor: Colors.white,

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 80.h),
                  child: Column(
                    children: [
                      _questionBlock(
                        question: 'Q. What is your pressing problem?',
                        options: ['Tooth Ache', 'Bleeding', 'Gums', 'Advice'],
                        selectedValue: _pressingProblem,
                        onSelect: (value) {
                          setState(() => _pressingProblem = value);
                        },
                      ),
                      _questionBlock(
                        question: 'Q. What kind of doctor are you seeking?',
                        options: ['General Dentist', 'Specialist', 'Orthodontics', 'Periodontist'],
                        selectedValue: _doctorSeeking,
                        onSelect: (value) {
                          setState(() => _doctorSeeking = value);
                        },
                      ),
                      _questionBlock(
                        question: 'Q. What is your doctor\'s specialization?',
                        options: ['General Practice', 'Surgery', 'Pediatrics', 'Cosmetic Dentistry'],
                        selectedValue: _doctorSpecialization,
                        onSelect: (value) {
                          setState(() => _doctorSpecialization = value);
                        },
                      ),
                      _questionBlock(
                        question: 'Q. How urgent is your visit?',
                        options: ['Immediate', 'Within 24 hours', 'This week', 'No rush'],
                        selectedValue: _visitUrgency,
                        onSelect: (value) {
                          setState(() => _visitUrgency = value);
                        },
                      ),
                      _questionBlock(
                        question: 'Q. Do you have insurance coverage?',
                        options: ['Yes', 'No', 'Not Sure'],
                        selectedValue: _insuranceCoverage,
                        onSelect: (value) {
                          setState(() => _insuranceCoverage = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: GestureDetector(
                  onTap: isContinueEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DentistListScreen(),
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    width: double.infinity,  // Full width
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: isContinueEnabled
                          ? const Color(0xFF469BFF)
                          : const Color(0xFFB0C4DE),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.continueText,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.white,
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

  Widget _questionBlock({
    required String question,
    required List<String> options,
    required String? selectedValue,
    required void Function(String) onSelect,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.only(top: 18.h, left: 19.w, right: 10.w, bottom: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: const Color(0xFF2A2A2A),
            ),
          ),
          SizedBox(height: 12.h),
          ...options.map(
            (option) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _optionTile(
                option,
                isSelected: selectedValue == option,
                onTap: () => onSelect(option),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile(String text, {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0x1AFFC83B)
              : const Color(0xFFEDEDED).withOpacity(0.4),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFFC83B)
                : const Color(0xFFEDEDED).withOpacity(0.4),
          ),
        ),
        padding: EdgeInsets.only(left: 16.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            if (isSelected) ...[
              Container(
                width: 16.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC83B),
                  
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Image.asset(
                  'assets/Images/lucide_check.png',
                  width: 12.w,
                  height: 12.h,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14.sp,
                color: const Color(0xFF2A2A2A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
