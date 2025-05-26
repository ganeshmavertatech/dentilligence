import 'package:dentilligence/View/Search/doctor_details_screen.dart';
import 'package:dentilligence/View/Search/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Constants
const Color kPrimaryColor = Color(0xFF469BFF);
const Color kTextColor = Color(0xFF2A2A2A);
const Color kSecondaryTextColor = Color(0xFF909090);
const Color kWhiteColor = Colors.white;
const Color kRatingGreen = Color(0xFF189958);
const Color kRatingYellow = Color(0xFFFFC83B);
const Color kShadowColor = Color(0x0D000000);
const Color kBorderColor = Color(0xFFEDEDED);

class DentistListScreen extends StatelessWidget {
  const DentistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar placeholder
            SizedBox(height: 18.h),
            
            // Header section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/Images/arrow_back.png', 
                      width: 24.w, 
                      height: 24.h,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.arrow_back, size: 24.w),
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    AppLocalizations.of(context)!.listofdentists,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/Images/iconamoon_search.png', 
                    width: 24.w, 
                    height: 24.h,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.search, size: 24.w),
                  ),
                  SizedBox(width: 20.w),
                  FilterIconWithBadge(),
                ],
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Consultation type selector
            _buildConsultationTypeSelector(context),
            
            SizedBox(height: 20.h),
            
            // Dentist list
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorDetailsPage()),
                        );
                      },
                      child: _buildDentistCard(
                        name: 'Dr. Ritu Bose',
                        specialties: 'Dentist, Orthodontics, Dental surgeon',
                        experience: '15 Yrs Exp',
                        patients: '125 Patients',
                        rating: '5.0',
                        fee: '\$50 ${AppLocalizations.of(context)!.fees}',
                        imageUrl: 'assets/Images/doctor1.png',
                        verified: true,
                        ratingColor: kRatingGreen,
                      ),
                    ),
                    
                    Divider(height: 1.h, thickness: 1.h, indent: 20.w, endIndent: 20.w),
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorDetailsPage()),
                        );
                      },
                      child: _buildDentistCard(
                        name: 'Dr. Ritesh Bhosale',
                        specialties: 'Orthodontics',
                        experience: '15 Yrs Exp',
                        patients: '125 Patients',
                        rating: '4.5',
                        fee: '\$50 ${AppLocalizations.of(context)!.fees}',
                        imageUrl: 'assets/Images/male_dr.png',
                        verified: true,
                        ratingColor: kRatingYellow,
                      ),
                    ),
                    
                    Divider(height: 1.h, thickness: 1.h, indent: 20.w, endIndent: 20.w),
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorDetailsPage()),
                        );
                      },
                      child: _buildDentistCard(
                        name: 'Dr. Chris Jorden',
                        specialties: 'Dentist, Orthodontics, Dental surgeon, Pe...',
                        experience: '15 Yrs Exp',
                        patients: '125 Patients',
                        rating: '4.5',
                        fee: '\$50 ${AppLocalizations.of(context)!.fees}',
                        imageUrl: 'assets/Images/doctor.png',
                        verified: true,
                        ratingColor: kRatingYellow,
                      ),
                    ),
                    
                    Divider(height: 1.h, thickness: 1.h, indent: 20.w, endIndent: 20.w),
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorDetailsPage()),
                        );
                      },
                      child: _buildDentistCard(
                        name: 'Dr. kayle Mills',
                        specialties: 'Dentist, Orthodontics, Dental surgeon',
                        experience: '15 Yrs Exp',
                        patients: '125 Patients',
                        rating: '4.5',
                        fee: '\$50 ${AppLocalizations.of(context)!.fees}',
                        imageUrl: 'assets/Images/im.png',
                        verified: false,
                        infoIcon: true,
                        ratingColor: kRatingYellow,
                        actionButton: _buildMapViewButton(context),
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

  Widget _buildConsultationTypeSelector(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kBorderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 145.w,
              height: 44.h,
              margin: EdgeInsets.all(5.h),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Images/clinic_icon_1.png',
                    width: 20.w,
                    height: 20.h,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.medical_services, size: 20.w),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    AppLocalizations.of(context)!.bookInClinic,
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Image.asset(
              'assets/Images/camera.png', 
              width: 20.w, 
              height: 20.h,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.videocam, size: 18.w),
            ),
            SizedBox(width: 5.w),
            Text(
              AppLocalizations.of(context)!.videoConsultation,
              style: TextStyle(
                fontSize: 16.sp,
                color: kTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDentistCard({
  required String name,
  required String specialties,
  required String experience,
  required String patients,
  required String rating,
  required String fee,
  required String imageUrl,
  required Color ratingColor,
  bool verified = false,
  bool infoIcon = false,
  Widget? actionButton,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dentist image with overlapping rating
        Stack(
          clipBehavior: Clip.none, // Allow overflow
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                imageUrl,
                width: 82.w,
                height: 82.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 82.w,
                  height: 82.h,
                  color: Colors.grey[200],
                  child: Icon(Icons.person, size: 40.w),
                ),
              ),
            ),
            // Half-in, half-out rating badge
            Positioned(
              bottom: -10.h, // Half outside the image
              left: 19.w,
              child: Container(
                width: 45.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: ratingColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 10.w, color: kWhiteColor),
                    SizedBox(width: 2.w),
                    Text(
                      rating,
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(width: 20.w),
        
        // Dentist details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  if (verified)
                    Icon(Icons.verified, size: 20.w, color: Colors.blue),
                  if (infoIcon)
                    Icon(Icons.info_outline, size: 20.w),
                ],
              ),
              
              SizedBox(height: 5.h),
              
              Text(
                specialties,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: kSecondaryTextColor,
                ),
              ),
              
              SizedBox(height: 10.h),
              
              Row(
                children: [
                  _buildDetailItem(
                    icon: Image.asset(
                      'assets/Images/solar_suitcase-linear.png', 
                      width: 14.w, 
                      height: 14.h,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.work, size: 14.w),
                    ),
                    text: experience,
                  ),
                  SizedBox(width: 20.w),
                  _buildDetailItem(
                    icon: Image.asset(
                      'assets/Images/hugeicons_patient.png', 
                      width: 14.w, 
                      height: 14.h,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.people, size: 14.w),
                    ),
                    text: patients,
                  ),
                ],
              ),
              
              SizedBox(height: 10.h),
              
              Row(
                children: [
                  Text(
                    fee,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const Spacer(),
                  if (actionButton != null) actionButton,
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildDetailItem({required Widget icon, required String text}) {
    return Row(
      children: [
        icon,
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: kTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMapViewButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapViewScreen()),
        );
      },
      child: Container(
        width: 102.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: kTextColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 14.w, color: kWhiteColor),
            SizedBox(width: 4.w),
            Text(
              AppLocalizations.of(context)!.mapView,
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterIconWithBadge extends StatelessWidget {
  const FilterIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FilterScreen()),
            );
          },
          child: Image.asset(
            'assets/Images/mage_filter.png', 
            width: 24.w, 
            height: 24.h,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.filter_alt, size: 24.w),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 12.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC320),
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: const Color(0xFFF9F9F9),
                width: 2.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          // Background Map Image
          Image.asset(
            'assets/Images/Map Image.png',
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200]),
          ),

          // Search bar
          Positioned(
            top: 71.h,
            left: 20.w,
            child: Container(
              width: 350.w,
              height: 54.h,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                    color: kShadowColor,
                    blurRadius: 6,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 15.w),
                  Image.asset(
                    'assets/Images/iconamoon_search.png',
                    width: 20.w,
                    height: 20.h,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.search, size: 20.w),
                  ),
                  SizedBox(width: 7.w),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search doctors by name/categories',
                        hintStyle: TextStyle(
                          color: kSecondaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Location markers
          Positioned(
            top: 214.h,
            left: 267.w,
            child: Image.asset(
              'assets/Images/Location Image.png',
              width: 44.w,
              height: 51.h,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.location_on, size: 44.w, color: Colors.red),
            ),
          ),

          Positioned(
            top: 281.h,
            left: 84.w,
            child: Image.asset(
              'assets/Images/Location Image.png',
              width: 44.w,
              height: 51.h,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.location_on, size: 44.w, color: Colors.red),
            ),
          ),

          // Doctor profile images
          Positioned(
            top: 219.h,
            left: 272.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.r),
              child: Image.asset(
                'assets/Images/doctor1.png',
                width: 34.w,
                height: 34.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 34.w,
                  height: 34.h,
                  color: Colors.grey[200],
                  child: Icon(Icons.person, size: 20.w),
                ),
              ),
            ),
          ),

          Positioned(
            top: 286.h,
            left: 89.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.r),
              child: Image.asset(
                'assets/Images/doctor1.png',
                width: 34.w,
                height: 34.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 34.w,
                  height: 34.h,
                  color: Colors.grey[200],
                  child: Icon(Icons.person, size: 20.w),
                ),
              ),
            ),
          ),

          // Doctor card
          Positioned(
            bottom: 120.h,
            left: 13.w,
            child: Container(
              width: 350.w,
              height: 126.h,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Stack(
                children: [
                  // Doctor image
                  Positioned(
                    top: 13.h,
                    left: 35.w,
                    child: Image.asset(
                      'assets/Images/doctor1.png',
                      width: 82.w,
                      height: 82.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 82.w,
                        height: 82.h,
                        color: Colors.grey[200],
                        child: Icon(Icons.person, size: 40.w),
                      ),
                    ),
                  ),

                  // Doctor name
                  Positioned(
                    top: 13.h,
                    left: 134.w,
                    child: Text(
                      'Dr. Ritu Bose',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Verified icon
                  Positioned(
                    top: 14.h,
                    left: 245.w,
                    child: Image.asset(
                      'assets/Images/material-symbols_verified-rounded.png',
                      width: 20.w,
                      height: 20.h,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.verified, size: 20.w, color: Colors.blue),
                    ),
                  ),

                  // Doctor specialties
                  Positioned(
                    top: 40.h,
                    left: 134.w,
                    child: Text(
                      'Dentist, Orthodontics, Dental surgeon',
                      style: TextStyle(
                        color: kSecondaryTextColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  // Experience
                  Positioned(
                    bottom: 49.h,
                    left: 137.w,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/Images/solar_suitcase-linear.png',
                          width: 14.w,
                          height: 14.h,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.work, size: 14.w),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '15 Yrs Exp',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Patients
                  Positioned(
                    bottom: 49.h,
                    left: 241.w,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/Images/hugeicons_patient.png',
                          width: 14.w,
                          height: 14.h,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.people, size: 14.w),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '125 Patients',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Rating
                  Positioned(
                    bottom: 18.h,
                    left: 54.w,
                    child: Container(
                      width: 45.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: kRatingGreen,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 10.w, color: kWhiteColor),
                          SizedBox(width: 2.w),
                          Text(
                            '5.0',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Fees
                  Positioned(
                    bottom: 18.h,
                    left: 138.w,
                    child: Text(
                      '\$50 ${AppLocalizations.of(context)!.fees}',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}