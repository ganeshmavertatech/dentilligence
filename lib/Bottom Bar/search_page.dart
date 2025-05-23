import 'package:dentilligence/Bottom%20Bar/list_of_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPageScreen extends StatefulWidget {
  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Ritu Bose',
      'specialty': 'General dentist, Orthodontics, Dental surgeon',
      'rating': 4.5,
      'image': 'assets/Images/doctor.png',
      'experience': '5 years',
      'patient_count': 200,
      'fee': '\$50'
    },
    {
      'name': 'Dr. Ritu Bose',
      'specialty': 'General dentist, Orthodontics, Dental surgeon',
      'rating': 4.5,
      'image': 'assets/Images/doctor.png',
      'experience': '5 years',
      'patient_count': 200,
      'fee': '\$50'
    },
    {
      'name': 'Dr. Ritu Bose',
      'specialty': 'General dentist, Orthodontics, Dental surgeon',
      'rating': 4.5,
      'image': 'assets/Images/doctor.png',
      'experience': '5 years',
      'patient_count': 200,
      'fee': '\$50'
    },
    {
      'name': 'Dr. Ritu Bose',
      'specialty': 'General dentist, Orthodontics, Dental surgeon',
      'rating': 4.5,
      'image': 'assets/Images/doctor.png',
      'experience': '5 years',
      'patient_count': 200,
      'fee': '\$50'
    }
  ];

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 196, 32, 0.2),
              Color.fromRGBO(245, 103, 253, 0.1),
              Color.fromRGBO(245, 103, 253, 0.2),
              Color.fromRGBO(42, 202, 234, 0.1),
              Colors.white.withOpacity(0.2)
            ],
            stops: [0.0, 0.45, 0.5, 0.75, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.dg),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 12.dg),
                      padding: EdgeInsets.all(8.dg),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    "List of doctors",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(43, 43, 43, 1),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.dg),
                    child: Image.asset(
                      'assets/Icons/search-filter.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 54.h,
              width: 350.w,
              margin: EdgeInsets.all(1.dg),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.dg), // Horizontal padding only
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: Color.fromRGBO(70, 76, 217, 1),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search doctors by name",
                          hintStyle: TextStyle(
                            fontFamily: "Gilroy",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(43, 43, 43, 0.6),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(43, 43, 43, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              margin: EdgeInsets.all(7),
              child: Row(
                children: [
                  _buildFilterContainer("Verified"),
                  _buildFilterContainer("10 years of Experience"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Container(
                    height: 165,
                    width: 350,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(10), // Reduced from 12
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            doctor['image'],
                            width: 90,
                            height: 135,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${doctor['name']}",
                                        style: TextStyle(
                                          fontFamily: 'Gluten',
                                          color: Color.fromRGBO(43, 43, 43, 1),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.verified,
                                        color:
                                            Color.fromRGBO(42, 202, 234, 1),
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 22,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(42, 202, 234, 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${doctor['rating']}",
                                            style: TextStyle(
                                              fontFamily: "Gluten",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4), // Reduced from 6
                              Text(
                                "${doctor['specialty']}",
                                style: TextStyle(
                                  fontFamily: "Gluten",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(43, 43, 43, 1),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6), // Reduced from 8
                              Row(
                                children: [
                                  Icon(
                                    Icons.work_outline,
                                    size: 16,
                                    color: Color.fromRGBO(100, 100, 100, 1),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${doctor['experience']} Exp",
                                    style: TextStyle(
                                      fontFamily: "Gluten",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(43, 43, 43, 1),
                                    ),
                                  ),
                                  SizedBox(width: 10.dg),
                                  Icon(
                                    Icons.person_2_outlined,
                                    size: 16.sp,
                                    color: Color.fromRGBO(100, 100, 100, 1),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${doctor['patient_count']} patients",
                                    style: TextStyle(
                                      fontFamily: "Gluten",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(43, 43, 43, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${doctor['fee']}",
                                    style: TextStyle(
                                      fontFamily: "Gluten",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromRGBO(43, 43, 43, 1),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SpecificDoctorScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4), // Reduced padding
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(69, 76, 217, 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "View details",
                                            style: TextStyle(
                                              fontFamily: "Gluten",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(42, 202, 234, 1),
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color:
                                                Color.fromRGBO(69, 76, 217, 1),
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterContainer(String fill) {
    return Container(
      height: 35,
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(69, 76, 217, 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color.fromRGBO(255, 196, 32, 0.6),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align elements
          children: [
            Text(
              fill,
              style: TextStyle(
                fontFamily: "Gilroy",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(43, 43, 43, 1),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.cancel_outlined,
              size: 20,
            ), // Properly aligned icon
          ],
        ),
      ),
    );
  }
}
