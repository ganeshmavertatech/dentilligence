import 'package:dentilligence/View/Search/payIn_clinic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorAvailabilityScreen extends StatefulWidget {
  const DoctorAvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<DoctorAvailabilityScreen> createState() =>
      _DoctorAvailabilityScreenState();
}

class _DoctorAvailabilityScreenState extends State<DoctorAvailabilityScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  int selectedDay = DateTime.now().day;
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                // Header with back button and doctor name
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
                    Text(
                      'Dr. Ritu Bose',
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

                SizedBox(height: 22.h),

                // Calendar Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFEDEDED),
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Month navigation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentMonth = DateTime(
                                  currentMonth.year,
                                  currentMonth.month - 1,
                                  1,
                                );
                              });
                            },
                            child: Image.asset(
                              'assets/Images/Previous.png',
                              width: 11.w,
                              height: 11.h,
                            ),
                          ),
                          Text(
                            _getMonthYearText(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2A2A2A),
                              fontSize: 16.sp,
                              height: 1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentMonth = DateTime(
                                  currentMonth.year,
                                  currentMonth.month + 1,
                                  1,
                                );
                              });
                            },
                            child: Image.asset(
                              'assets/Images/Next.png',
                              width: 11.w,
                              height: 11.h,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Calendar grid
                      _buildCalendarGrid(),
                    ],
                  ),
                ),

                SizedBox(height: 35.h),

                // Available slots title
                Text(
                  AppLocalizations.of(context)!.availableSlots,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2A2A2A),
                    fontSize: 18.sp,
                    height: 1.33,
                  ),
                ),

                SizedBox(height: 24.h),

                // Time categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeCategory(
                      icon: 'assets/Images/cloud.png',
                      label: AppLocalizations.of(context)!.morning,
                      isActive: true,
                    ),
                    _buildTimeCategory(
                      icon: 'assets/Images/meteoconstimeafternoon0.png',
                      label: AppLocalizations.of(context)!.afternoon,
                      isActive: false,
                    ),
                    _buildTimeCategory(
                      icon: 'assets/Images/meteoconsTimeNight0.png',
                      label: AppLocalizations.of(context)!.evening,
                      isActive: false,
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Divider with indicator
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: const Color(0xFFEDEDED),
                    ),
                    Container(
                      width: 115.w,
                      height: 2.h,
                      color: const Color(0xFF469BFF),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Time slots grid
                Column(
                  children: [
                    // Row 1
                    _buildTimeSlotRow(
                      slot1: "9.00 AM",
                      slot2: "9.15 AM",
                      slot3: "9.30 AM",
                      selectedSlot: selectedTimeSlot,
                      onSlotSelected: (slot) {
                        setState(() {
                          selectedTimeSlot = slot;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),

                    // Row 2
                    _buildTimeSlotRow(
                      slot1: "10.00 AM",
                      slot2: "10.15 AM",
                      slot3: "10.30 AM",
                      selectedSlot: selectedTimeSlot,
                      onSlotSelected: (slot) {
                        setState(() {
                          selectedTimeSlot = slot;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),

                    // Row 3
                    _buildTimeSlotRow(
                      slot1: "11.30 AM",
                      slot2: "12.00 PM",
                      slot3: "12.15 PM",
                      isSlot2Available: false,
                      selectedSlot: selectedTimeSlot,
                      onSlotSelected: (slot) {
                        setState(() {
                          selectedTimeSlot = slot;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),

                    // Row 4
                    _buildTimeSlotRow(
                      slot1: "3.30 PM",
                      slot2: "3.45 PM",
                      slot3: "4.15 PM",
                      isSlot3Available: false,
                      selectedSlot: selectedTimeSlot,
                      onSlotSelected: (slot) {
                        setState(() {
                          selectedTimeSlot = slot;
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                // Book Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedTimeSlot == null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PayInClinicScreen()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF469BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      elevation: 0,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.bookNow,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBookingConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Appointment Booked',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          'Your appointment with Dr. Ritu Bose on ${DateFormat('MMMM d, y').format(DateTime(selectedDate.year, selectedDate.month, selectedDay))} at $selectedTimeSlot has been confirmed.',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Lato',
                color: const Color(0xFF469BFF),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCategory({
    required String icon,
    required String label,
    required bool isActive,
  }) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 20.w,
          height: 20.h,
          color: isActive ? const Color(0xFF469BFF) : const Color(0xFF909090),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? const Color(0xFF469BFF) : const Color(0xFF909090),
            fontSize: 14.sp,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotRow({
    required String slot1,
    required String slot2,
    required String slot3,
    bool isSlot1Available = true,
    bool isSlot2Available = true,
    bool isSlot3Available = true,
    required String? selectedSlot,
    required Function(String) onSlotSelected,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeSlot(
          slot1,
          isSlot1Available,
          isSelected: selectedSlot == slot1,
          onTap: () => onSlotSelected(slot1),
        ),
        _buildTimeSlot(
          slot2,
          isSlot2Available,
          isSelected: selectedSlot == slot2,
          onTap: () => onSlotSelected(slot2),
        ),
        _buildTimeSlot(
          slot3,
          isSlot3Available,
          isSelected: selectedSlot == slot3,
          onTap: () => onSlotSelected(slot3),
        ),
      ],
    );
  }

  String _getMonthYearText() {
    return DateFormat('MMMM yyyy').format(currentMonth);
  }

  Widget _buildCalendarGrid() {
    int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    int firstDayOfMonth =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday;
    firstDayOfMonth = firstDayOfMonth % 7;
    List<String> weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdays.map((day) {
            bool isWeekend = day == 'Su' || day == 'Sa';
            Color textColor =
                isWeekend ? const Color(0xFF909090) : const Color(0xFF2A2A2A);

            return SizedBox(
              width: 38.w,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontSize: 14.sp,
                  height: 1,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 15.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 15.h,
            crossAxisSpacing: 5.w,
            childAspectRatio: 1,
          ),
          itemCount: 42,
          itemBuilder: (context, index) {
            int dayNumber = index + 1 - firstDayOfMonth;
            bool isCurrentMonth = dayNumber > 0 && dayNumber <= daysInMonth;
            bool isSelected = isCurrentMonth && dayNumber == selectedDay;

            bool isRedDay = false;
            if (isCurrentMonth) {
              DateTime day =
                  DateTime(currentMonth.year, currentMonth.month, dayNumber);
              isRedDay = day.weekday == 6 ||
                  day.weekday == 7 ||
                  [17, 20, 29].contains(dayNumber);
            }

            if (!isCurrentMonth) {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDay = dayNumber;
                });
              },
              child: Container(
                decoration: isSelected
                    ? BoxDecoration(
                        color: const Color(0xFF469BFF),
                        shape: BoxShape.circle,
                      )
                    : null,
                child: Center(
                  child: Text(
                    dayNumber.toString(),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w400,
                      color: isSelected
                          ? Colors.white
                          : isRedDay
                              ? const Color(0xFFB22828)
                              : const Color(0xFF909090),
                      fontSize: 14.sp,
                      height: 1,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeSlot(
    String time,
    bool isAvailable, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        width: 110.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF469BFF)
                : isAvailable
                    ? const Color(0xFF2A2A2A).withOpacity(0.5)
                    : const Color(0xFF909090).withOpacity(0.5),
            width: isSelected ? 1.5.w : 0.5.w,
          ),
          color: isSelected ? const Color(0xFF469BFF).withOpacity(0.1) : null,
        ),
        child: Center(
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected
                  ? const Color(0xFF469BFF)
                  : isAvailable
                      ? const Color(0xFF469BFF)
                      : const Color(0xFF909090).withOpacity(0.5),
              fontSize: 14.sp,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
