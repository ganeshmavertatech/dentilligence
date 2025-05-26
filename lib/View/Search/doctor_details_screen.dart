import 'package:dentilligence/View/Search/doctor_avaibility.dart';
import 'package:dentilligence/View/Search/pay_online.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorDetailsPage extends StatelessWidget {
  const DoctorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with doctor image
            Stack(
              children: [
                Container(
                  height: 260.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Images/im.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 55.h,
                  left: 20.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: _buildCircleButton(Icons.arrow_back),
                  ),
                ),
                Positioned(
                  top: 55.h,
                  right: 60.w,
                  child: _buildCircleButton(Icons.notifications),
                ),
                Positioned(
                  top: 55.h,
                  right: 20.w,
                  child: _buildCircleButton(Icons.share),
                ),
              ],
            ),

            // Doctor details content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  _buildDoctorHeader(),
                  SizedBox(height: 30.h),

                  // Availability section
                  _buildSectionHeader(
                    title: AppLocalizations.of(context)!.checkAvailability,
                    actionText: AppLocalizations.of(context)!.viewAllSlots,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const DoctorAvailabilityScreen()),
                      );
                    },
                  ),

                  SizedBox(height: 15.h),
                  _buildAvailabilityCard(context),
                  SizedBox(height: 30.h),

                  // Clinic timing
                  _buildSectionHeader(title: AppLocalizations.of(context)!.clinicTiming),
                  SizedBox(height: 10.h),
                  _buildClinicTimingRow(
                    days: "Mon - Fri",
                    time1: "9 AM - 3 PM",
                    time2: "4 PM - 9 PM",
                  ),
                  SizedBox(height: 8.h),
                  _buildClinicTimingRow(
                    days: "Sat",
                    time1: "9 AM - 2 PM",
                    time2: null,
                  ),
                  SizedBox(height: 30.h),

                  // Clinic address
                  _buildSectionHeader(title: AppLocalizations.of(context)!.clinicAddress),
                  SizedBox(height: 10.h),
                  _buildInfoRow(
                    icon: Icons.location_on,
                    text: "2.4mi, 80 Ridgeway road, Sheffield, S12 2SX",
                  ),
                  SizedBox(height: 30.h),
                  
                  // Language spoken
                  _buildSectionHeader(title: AppLocalizations.of(context)!.languageSpoken), 
                  SizedBox(height: 10.h),
                  _buildLangRow(
                    icon: Icons.language,
                    text: "English, Hindi, Marathi",
                  ),
                  SizedBox(height: 30.h),
                  // Featured services
                  _buildSectionHeader(title: AppLocalizations.of(context)!.featuredServices),
                  SizedBox(height: 10.h),
                  _buildServiceItem(AppLocalizations.of(context)!.familyPractice),
                  _buildServiceItem(AppLocalizations.of(context)!.teethWhitening),
                  _buildServiceItem(AppLocalizations.of(context)!.invisibleBraces),
                  _buildServiceItem(AppLocalizations.of(context)!.facialAesthetics),
                  _buildServiceItem(AppLocalizations.of(context)!.nhsPrivate),
                  SizedBox(height: 30.h),

                  // About doctor
                  _buildSectionHeader(title: AppLocalizations.of(context)!.aboutDoctor),
                  SizedBox(height: 10.h),
                  Text(
                    "Dr. Ritu Bose",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: const Color(0xFF2A2A2A),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Find experienced and trusted dentists near you for "
                    "cleanings, check-ups, cosmetic treatments, and more. "
                    "Book appointments with ease and keep your smile healthy",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 30.h),

                  // Patient reviews
                  _buildSectionHeader(
                    title: AppLocalizations.of(context)!.whatPatientsSay,
                    actionText: AppLocalizations.of(context)!.readAll,
                  ),
                  SizedBox(height: 15.h),
                  _buildPatientReview(),
                  SizedBox(height: 15.h),
                  Text(
                    "+ ${AppLocalizations.of(context)!.addFeedback}",
                    style: TextStyle(
                      color: const Color(0xFF469BFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Booking buttons
                  _buildBookingButtons(context),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20.sp),
    );
  }

  Widget _buildDoctorHeader() {
    return Stack(
      children: [
        Text(
          "Dr. Ritu Bose",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2A2A2A),
          ),
        ),
        Positioned(
          right: 0,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF189958),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 16.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      "4.5",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w), // spacing between box and arrow
              Icon(Icons.chevron_right,
                  size: 20.sp, color: Colors.black), 
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 35.h),
          child: Text(
            "Dentist, Orthodontics, Dental surgeon",
            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF2A2A2A)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 70.h),
          child: Row(
            children: [
              _buildInfoChip(Icons.work, "15 Yrs Exp"),
              SizedBox(width: 20.w),
              _buildInfoChip(Icons.people, "125 Patients"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: const Color(0xFF2A2A2A)),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2A2A2A),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    String? actionText,
    VoidCallback? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2A2A2A),
          ),
        ),
        if (actionText != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: TextStyle(
                color: const Color(0xFF469BFF),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAvailabilityCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildVisitOption(AppLocalizations.of(context)!.visitClinic, true, onTap: () {
                // Optionally handle Visit Clinic tap
              }),
              SizedBox(width: 20.w),
              _buildVisitOption(AppLocalizations.of(context)!.videoConsultation , false, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              }),
            ],
          ),
          Divider(height: 30.h, thickness: 1),
          Text(
            "Team dental",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2A2A2A),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text("London", style: TextStyle(fontSize: 14.sp)),
              SizedBox(width: 5.w),
              CircleAvatar(
                  radius: 2.r, backgroundColor: const Color(0xFF909090)),
              SizedBox(width: 5.w),
              Text("15km away", style: TextStyle(fontSize: 14.sp)),
              const Spacer(),
              Text(
                "\$50 " + AppLocalizations.of(context)!.fees,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2A2A2A),
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildDateSlot("Today", "6 slots", true),
                SizedBox(width: 10.w),
                _buildDateSlot("Tomorrow", "20 slots", false),
                SizedBox(width: 10.w),
                _buildDateSlot("16 May", "15 slots", false),
                SizedBox(width: 10.w),
                _buildDateSlot("17 May", "15 slots", false),
                SizedBox(width: 10.w),
                _buildDateSlot("18", "15", false),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTimeSlot("3.30 PM"),
                SizedBox(width: 10.w),
                _buildTimeSlot("3.45 PM"),
                SizedBox(width: 10.w),
                _buildTimeSlot("4.15 PM"),
                SizedBox(width: 10.w),
                _buildTimeSlot("7.30 PM"),
                SizedBox(width: 10.w),
                _buildTimeSlot("8.00 PM"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitOption(String text, bool isSelected,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF469BFF).withOpacity(0.05) : null,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.local_hospital : Icons.videocam,
              size: 16.sp,
              color: isSelected
                  ? const Color(0xFF469BFF)
                  : const Color(0xFF979797),
            ),
            SizedBox(width: 5.w),
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF469BFF)
                    : const Color(0xFF979797),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSlot(String date, String slots, bool isSelected) {
    return Container(
      width: isSelected ? 70.w : 65.w,
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF469BFF).withOpacity(0.05) : null,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFF909090).withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFF909090),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            slots,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF469BFF)
                  : const Color(0xFF2A2A2A),
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF469BFF), width: 0.5),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: const Color(0xFF469BFF),
          fontWeight: FontWeight.bold,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  Widget _buildClinicTimingRow({
    required String days,
    required String? time1,
    String? time2,
  }) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 20.sp, color: const Color(0xFF909090)),
        SizedBox(width: 5.w),
        SizedBox(
          width: 80.w,
          child: Text(days, style: TextStyle(fontSize: 14.sp)),
        ),
        Text(
          time1 ?? '',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        if (time2 != null) ...[
          SizedBox(width: 20.w),
          Text(
            time2,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFF909090)),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        Icon(Icons.arrow_outward, size: 20.sp, color: const Color(0xFF909090)),
      ],
    );
  }

  Widget _buildServiceItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16.sp, color: const Color(0xFF909090)),
          SizedBox(width: 5.w),
          Text(text, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _buildLangRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFF909090)),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildPatientReview() {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "AS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  "Adinath Shinde",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2A2A2A),
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Text(
                "2 Days ago",
                style:
                    TextStyle(color: const Color(0xFF979797), fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            "Booking an appointment was super easy, and the dentist visited was fantastic! "
            "The app even sent me reminders before my visit. Highly recommend for anyone "
            "looking for reliable dental care.",
            style: TextStyle(color: const Color(0xFF2A2A2A), fontSize: 14.sp),
          ),
          SizedBox(height: 10.h),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                size: 16.sp,
                color: const Color(0xFFFFC83B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DoctorAvailabilityScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF469BFF),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.bookInClinic,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF469BFF)),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.callClinic,
              style: TextStyle(
                color: const Color(0xFF469BFF),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
