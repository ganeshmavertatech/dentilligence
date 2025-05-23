import 'package:dentilligence/View/Search/assesment_screen.dart';
import 'package:dentilligence/View/Search/dental_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Good Morning, David",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/Images/tdesign_location-filled.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "London",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Transform.rotate(
                      angle: 90 * 3.1416 / 180, // 90 degrees in radians
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Image.asset(
                        'assets/Images/iconamoon_heart-light.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/Images/mage_notification-bell.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Search bar
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AssessmentScreen()),
                    );
                  },
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF8F8F8F).withOpacity(0.4),
                      ),
                    ),
                    child:  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Icon(Icons.search,
                              size: 20, color: Color(0xFF909090)),
                          SizedBox(width: 7),
                          Text(
                            AppLocalizations.of(context)!.searchDoctors,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF909090),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Promotion banner
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: const Color(0xFF469BFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Left Text & Button
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.newBookingPlan,
                              style: GoogleFonts.corben(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 110,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF469BFF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Learn More",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Right Doctor Image aligned to bottom
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            'assets/Images/booking-plan-bottom1.png',
                            width: 130,
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Looking For section
              const SizedBox(height: 30),
               Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context)!.lookingFor,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 0),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCategoryImageCircle(
                        'assets/Images/icon-park-outline_teeth.png', AppLocalizations.of(context)!.general),
                    _buildCategoryImageCircle(
                        'assets/Images/la_teeth-open.png',  AppLocalizations.of(context)!.orthodontist),
                    _buildCategoryImageCircle(
                        'assets/Images/icon-park-outline_teeth.png',
                        AppLocalizations.of(context)!.general),
                    _buildCategoryImageCircle(
                        'assets/Images/la_teeth-open.png',  AppLocalizations.of(context)!.pedodontist),
                    _buildCategoryImageCircle(
                        'assets/Images/icon-park-outline_teeth.png',  AppLocalizations.of(context)!.oralSurgeon),
                  ],
                ),
              ),

              // Quick Actions section
              const SizedBox(height: 30),
               Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context)!.quickActions,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionImageButton(
                        iconPath: 'assets/Images/clinic_icon_1.png',
                        label: AppLocalizations.of(context)!.bookInClinic,
                        isPrimary: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildQuickActionImageButton(
                        iconPath: 'assets/Images/majesticons_video.png',
                        label: AppLocalizations.of(context)!.bookVideo,
                        isPrimary: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryImageCircle(String iconPath, String label) {
  return Container(
    width: 90,
    margin: const EdgeInsets.only(right: 20), // Increased spacing between circles
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color.fromARGB(26, 255, 199, 59),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(18),
          child: Image.asset(iconPath, fit: BoxFit.contain),
        ),
        Positioned(
          bottom: 0, // Moves the label further below the circle
          child: SizedBox(
            width: 90,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildQuickActionImageButton({
    required String iconPath,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF469BFF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: const Color(0xFF469BFF)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: isPrimary ? Colors.white : const Color(0xFF469BFF),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isPrimary ? Colors.white : const Color(0xFF469BFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
