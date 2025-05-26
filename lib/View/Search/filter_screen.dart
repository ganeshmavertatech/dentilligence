import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Filter states
  String verificationStatus = 'both';
  String gender = 'both';
  List<int> selectedRatings = [4, 5];
  RangeValues priceRange = const RangeValues(20, 150);
  double distance = 50;
  Set<String> selectedLanguages = {'english'}; // Default selected

  @override
  Widget build(BuildContext context) {
    // Initialize screen util
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and close button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, size: 24.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2A2A2A),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFE0E0E0)),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    // Select Language
                    Text(
                      AppLocalizations.of(context)!.selectLanguage,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Wrap(
                      spacing: 20.w,
                      runSpacing: 10.h,
                      children: [
                        _buildLanguageCheckbox(
                            value: 'english', label: AppLocalizations.of(context)!.english),
                        _buildLanguageCheckbox(value: 'hindi', label: AppLocalizations.of(context)!.hindi),
                        _buildLanguageCheckbox(
                            value: 'ukrainian', label: AppLocalizations.of(context)!.ukrainian),
                      ],
                    ),
                    const Divider(
                        color: Color(0xFFE0E0E0), thickness: 1, height: 40),

                    // Sort By (Verification Status)
                    Text(
                      AppLocalizations.of(context)!.sortBy,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        _buildRadioButton(
                          value: 'both',
                          groupValue: verificationStatus,
                          label: AppLocalizations.of(context)!.both,
                          isSelected: verificationStatus == 'both',
                          onChanged: (value) {
                            setState(() {
                              verificationStatus = value!;
                            });
                          },
                        ),
                        SizedBox(width: 20.w),
                        _buildRadioButton(
                          value: 'verified',
                          groupValue: verificationStatus,
                          label: AppLocalizations.of(context)!.verified,
                          isSelected: verificationStatus == 'verified',
                          onChanged: (value) {
                            setState(() {
                              verificationStatus = value!;
                            });
                          },
                        ),
                        SizedBox(width: 20.w),
                        _buildRadioButton(
                          value: 'unverified',
                          groupValue: verificationStatus,
                          label: AppLocalizations.of(context)!.unverified,
                          isSelected: verificationStatus == 'unverified',
                          onChanged: (value) {
                            setState(() {
                              verificationStatus = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(
                        color: Color(0xFFE0E0E0), thickness: 1, height: 40),

                    // Gender
                    Text(
                      AppLocalizations.of(context)!.genderFilter,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        _buildRadioButton(
                          value: 'both',
                          groupValue: gender,
                          label: AppLocalizations.of(context)!.both,
                          isSelected: gender == 'both',
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        SizedBox(width: 25.w),
                        _buildRadioButton(
                          value: 'male',
                          groupValue: gender,
                          label: AppLocalizations.of(context)!.male,
                          isSelected: gender == 'male',
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        SizedBox(width: 25.w),
                        _buildRadioButton(
                          value: 'female',
                          groupValue: gender,
                          label: AppLocalizations.of(context)!.female,
                          isSelected: gender == 'female',
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(
                        color: Color(0xFFE0E0E0), thickness: 1, height: 40),

                    // Ratings
                    Text(
                      AppLocalizations.of(context)!.ratings,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: Wrap(
                        spacing: 18.w,
                        children: List.generate(5, (index) {
                          final rating = index + 1;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedRatings.contains(rating)) {
                                  selectedRatings.remove(rating);
                                } else {
                                  selectedRatings.add(rating);
                                }
                              });
                            },
                            child: Container(
                              width: 37.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: selectedRatings.contains(rating)
                                    ? const Color(0xFF469BFF)
                                    : const Color(0x33909090),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 18.w,
                                    child: Text(
                                      '$rating',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: selectedRatings.contains(rating)
                                            ? Colors.white
                                            : const Color(0xFF2A2A2A),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 3.h,
                                    left: 7.w,
                                    child: Icon(
                                      Icons.star,
                                      size: 12.sp,
                                      color: selectedRatings.contains(rating)
                                          ? Colors.white
                                          : const Color(0xFF2A2A2A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Divider(
                        color: Color(0xFFE0E0E0), thickness: 1, height: 40),

                    // Pricing
                    Text(
                      AppLocalizations.of(context)!.pricing,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.minimum,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF919191),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.maximum,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF919191),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    RangeSlider(
                      values: priceRange,
                      min: 0,
                      max: 200,
                      divisions: 20,
                      labels: RangeLabels(
                        '\$${priceRange.start.round()}',
                        '\$${priceRange.end.round()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          priceRange = values;
                        });
                      },
                      activeColor: const Color(0xFF469BFF),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPriceInput(priceRange.start.round().toString()),
                        _buildPriceInput(priceRange.end.round().toString()),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // Kilometers
                    Text(
                      AppLocalizations.of(context)!.kilometers,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Slider(
                      value: distance,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: '${distance.round()}km',
                      onChanged: (value) {
                        setState(() {
                          distance = value;
                        });
                      },
                      activeColor: const Color(0xFF469BFF),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16.sp, color: const Color(0xFF2A2A2A)),
                            SizedBox(width: 5.w),
                            Text(
                              '0km',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF2A2A2A),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '100km',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),

            // Apply/Reset buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          verificationStatus = 'both';
                          gender = 'both';
                          selectedRatings = [4, 5];
                          priceRange = const RangeValues(20, 150);
                          distance = 50;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        side: const BorderSide(color: Color(0xFF469BFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.reset,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF469BFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final filters = {
                          'verificationStatus': verificationStatus,
                          'gender': gender,
                          'ratings': selectedRatings,
                          'minPrice': priceRange.start,
                          'maxPrice': priceRange.end,
                          'distance': distance,
                        };
                        Navigator.pop(context, filters);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF469BFF),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.apply,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

  Widget _buildRadioButton({
    required String value,
    required String groupValue,
    required String label,
    required bool isSelected,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: const Color(0xFF469BFF),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color:
                isSelected ? const Color(0xFF2A2A2A) : const Color(0xFF909090),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInput(String value) {
    return Container(
      width: 96.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF919191), width: 0.5),
      ),
      child: Center(
        child: Text(
          '\$$value',
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFF2A2A2A),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCheckbox({
    required String value,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: selectedLanguages.contains(value),
          onChanged: (bool? checked) {
            setState(() {
              if (checked == true) {
                selectedLanguages.add(value);
              } else {
                selectedLanguages.remove(value);
              }
            });
          },
          activeColor: const Color(0xFF469BFF),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF2A2A2A),
          ),
        ),
      ],
    );
  }
}
