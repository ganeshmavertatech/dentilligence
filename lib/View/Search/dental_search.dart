import 'package:dentilligence/View/Search/asesmen_screen_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 390,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with location
                Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.arrow_back, size: 24),
                          SizedBox(width: 7),
                          Icon(
                            Icons.location_on,
                            size: 24,
                            color: Color(0xFF469BFF),
                          ),
                          SizedBox(width: 2),
                          Text(
                            'London',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.keyboard_arrow_down, size: 15),
                        ],
                      ),
                      Icon(Icons.favorite_border, size: 28),
                    ],
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF2A2A2A)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText:  AppLocalizations.of(context)!
                                    .searchHere,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF909090).withOpacity(0.3),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Specialists section
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Text(
                     AppLocalizations.of(context)!
                                    .specialists,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF909090),
                    ),
                  ),
                ),

                // Specialist chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      _buildSpecialistChip('Dentist'),
                      SizedBox(width: 10),
                      _buildSpecialistChip('Orthodontist'),
                      SizedBox(width: 10),
                      _buildSpecialistChip('Periodontist'),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    children: [
                      _buildSpecialistChip('Oral Surgeon'),
                      SizedBox(width: 10),
                      _buildSpecialistChip('Endodontist'),
                    ],
                  ),
                ),

                // Recommended section
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Text(
                     AppLocalizations.of(context)!
                                    .recommended,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF909090),
                    ),
                  ),
                ),

                // Doctor list
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      _buildDoctorCard(
                        'Dr. Ritu Bose',
                        'assets/Images/doctor1.png',
                      ),
                      Divider(
                          height: 40, thickness: 1, color: Color(0xFFE0E0E0)),
                      _buildDoctorCard(
                        'Dr. David Malan',
                        'assets/Images/female_dr.png',
                      ),
                      Divider(
                          height: 40, thickness: 1, color: Color(0xFFE0E0E0)),
                      _buildDoctorCard(
                        'Dr. David Malan',
                        'assets/Images/male_dr.png',
                      ),
                      Divider(
                          height: 40, thickness: 1, color: Color(0xFFE0E0E0)),
                      _buildDoctorCard(
                        'Dr. Ritu Bose',
                        'assets/Images/female_dr.png',
                      ),
                      Divider(
                          height: 40, thickness: 1, color: Color(0xFFE0E0E0)),
                      _buildDoctorCard(
                        'Dr. Ritu Bose',
                        'assets/Images/female_dr.png',
                      ),
                      Divider(
                          height: 40, thickness: 1, color: Color(0xFFE0E0E0)),
                      _buildDoctorCard(
                        'Dr. Ritu Bose',
                        'assets/Images/female_dr.png',
                      ),
                      Divider(
                          height: 40, thickness: 1, color: Color(0xFFE0E0E0)),
                      _buildDoctorCard(
                        'Dr. Ritu Bose',
                        'assets/Images/female_dr.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialistChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF909090), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2A2A2A),
            ),
          ),
          SizedBox(width: 5),
          Icon(Icons.arrow_outward, size: 16),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String imageUrl) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AssessmentScreenTwo()));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                imageUrl,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF469BFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 8, color: Colors.white),
                            SizedBox(width: 2),
                            Text(
                              '5.0',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      _buildLocationInfo('London'),
                      SizedBox(width: 10),
                      _buildLocationInfo('15km away'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Icon(Icons.chevron_right, size: 18),
            ),
          ],
        ));
  }

  Widget _buildLocationInfo(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Color(0xFF909090),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF909090),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyboardRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((key) => _buildKeyboardKey(key)).toList(),
      ),
    );
  }

  Widget _buildKeyboardKey(String text,
      {double width = 33, bool isSearch = false}) {
    return Container(
      width: width,
      height: 44,
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: isSearch ? Color(0xFF469BFF) : Color(0xFFFCFCFE),
        borderRadius: BorderRadius.circular(4.6),
        boxShadow: [
          if (!isSearch)
            BoxShadow(
              color: Color(0xFF898A8D),
              offset: Offset(0, 1),
            ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Red Hat Display',
            fontSize: isSearch ? 16 : 22.5,
            fontWeight: isSearch ? FontWeight.w700 : FontWeight.w500,
            color: isSearch ? Colors.white : Color(0xFF2A2A2A),
          ),
        ),
      ),
    );
  }
}
