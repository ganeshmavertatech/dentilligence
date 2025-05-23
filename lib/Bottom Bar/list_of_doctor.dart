import 'package:flutter/material.dart';

class SpecificDoctorScreen extends StatefulWidget {
  const SpecificDoctorScreen({Key? key}) : super(key: key);

  @override
  State<SpecificDoctorScreen> createState() => _SpecificDoctorScreenState();
}

class _SpecificDoctorScreenState extends State<SpecificDoctorScreen> {
  bool isFavorite = false;

  // Static data that can be replaced with dynamic data in the future
  final String imageUrl = "assets/Images/doctor.png";
  final Map<String, dynamic> doctorInfo = {
    'name': 'Dr. Ritu Bose',
    'specialty': 'General dentist, Orthodontics, Dental surgeon',
    'rating': 4.8,
    'reviewCount': 156,
    'experience': 12,
    'patients': 1500,
    'hospital': 'Heart & Vascular Institute',
    'about':
        'Dr. Sarah Johnson is a board-certified cardiologist with over 12 years of experience in diagnosing and treating heart conditions. She specializes in preventive cardiology and cardiac imaging.',
    'workingHours': {
      'Mon - Fri': '09:00 AM - 05:00 PM',
      'Saturday': '09:00 AM - 01:00 PM',
      'Sunday': 'Closed'
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top image with overlay buttons
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black87),
                            ),
                          ),

                          // Favorite button
                          InkWell(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Color.fromRGBO(42, 202, 234, 1)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Draggable sheet for doctor information
          DraggableScrollableSheet(
            initialChildSize: 0.53,
            minChildSize: 0.47,
            maxChildSize: 0.65,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15.0,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  child: _buildDoctorInfo(doctorInfo),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo(Map<String, dynamic> info) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                info['name'] ?? 'Doctor Name',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Gluten',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.verified,
                color: Color.fromRGBO(42, 202, 234, 1),
                size: 18,
              ),
              Spacer(),
              Container(
                width: 45,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(42, 202, 234, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 2),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 15,
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                        fontFamily: 'Gluten',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Specialty
          Text(
            info['specialty'] ?? 'Specialty',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontFamily: 'Gluten',
            ),
          ),
          SizedBox(height: 16),

          // Rating and reviews
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // icon for experience
              Icon(
                Icons.work_outline,
                size: 16,
              ),
              SizedBox(width: 1),
              Text(
                "15 Yrs Exp",
                style: TextStyle(
                    fontFamily: "Gluten",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.person_2_outlined,
                size: 16,
              ),
              SizedBox(width: 1),
              Text(
                "125 Patients",
                style: TextStyle(
                    fontFamily: "Gluten",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black),
              ),

              Spacer(),
              Text(
                "View Blogs",
                style: TextStyle(
                    fontFamily: "Gluten",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color.fromRGBO(42, 202, 234, 1)),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
                color: Color.fromRGBO(42, 202, 234, 1),
              ),
            ],
          ),

          SizedBox(height: 16),
          Container(
              width: 350,
              height: 38,
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(42, 202, 234, 0.1)),
              child: Center(
                child: Text("Opens weekdays till 9:30 PM",
                    style: TextStyle(
                        fontFamily: "Gluten",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(42, 202, 234, 1))),
              )),

          SizedBox(height: 16),

          Text(
            "CLINIC ADDRESS",
            style: TextStyle(
              fontFamily: "Gluten",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color.fromRGBO(144, 144, 144, 1),
              letterSpacing: 1.5,
            ),
          ),
          _infoRow(Icons.location_pin, 'Hospital',
              info['hospital'] ?? 'City Medical Center'),

          Divider(height: 32, color: Colors.grey[300]),

          // About section
          Text(
            "SERVICES",
            style: TextStyle(
              fontFamily: "Gluten",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color.fromRGBO(144, 144, 144, 1),
              letterSpacing: 1.5,
            ),
          ),
          _buildServiceRow("Family friendly practice"),
          _buildServiceRow("Teeth whitening"),
          _buildServiceRow("Invisalign invisible braces"),
          _buildServiceRow("Facial asthetics"),
          _buildServiceRow("NHS & Private"),

          SizedBox(height: 24),

          Container(
            child: _buildBottomButtons(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        // Choose Doctors button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Handle choose doctors action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(42, 202, 234, 1),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pentagon_sharp, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  'Visit Clinic',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: "Gilroy",
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Handle manual reason action
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(color: Color.fromRGBO(42, 202, 234, 1)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam_rounded,
                    color: Color.fromRGBO(42, 202, 234, 1), size: 20),
                SizedBox(width: 10),
                Text(
                  'Video Call',
                  style: TextStyle(
                    color: Color.fromRGBO(42, 202, 234, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: "Gilroy",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceRow(String service) {
    return Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 7,
        ),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              size: 7,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              service,
              style: TextStyle(
                fontFamily: "Gluten",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ));
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 22),
          SizedBox(width: 12),
          Text(
            value,
            style: TextStyle(
              fontFamily: "Gluten",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
