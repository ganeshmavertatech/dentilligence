import 'package:dentilligence/Bottom%20Bar/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dentilligence/Games/monster_game.dart';
import 'package:dentilligence/View/Search/dentist_list_page.dart';
import 'package:dentilligence/View/Video file/findings_screen.dart';
import 'package:dentilligence/screens/dashboard_screen.dart';
import 'package:dentilligence/screens/looking_for.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const DentistListScreen(),
    const GameHubScreen(),
    const FindingsScreen(),
    TeethChartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.r)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/Icons/navigation-home.png', AppLocalizations.of(context)!.home, 0),
            _buildImageNavItem(
                'assets/Images/icon-park-outline_teeth (1).png', AppLocalizations.of(context)!.consult, 1),
            _buildCenterItem(
                'assets/Images/hugeicons_online-learning-01.png', AppLocalizations.of(context)!.edutainment, 2),
            _buildNavItem('assets/Images/uil_analysis.png', AppLocalizations.of(context)!.findings, 3),
            _buildImageNavItem(
                'assets/Images/iconamoon_profile-light.png', AppLocalizations.of(context)!.account, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String asset, String label, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Makes the entire area tappable
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: 60.w, // Give enough tap area
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isActive)
              Container(
                height: 2.h,
                width: 24.w,
                color: const Color(0xFF469BFF),
              ),
            SizedBox(height: isActive ? 4.h : 6.h),
            Image.asset(
              asset,
              width: 24.w,
              height: 24.h,
              color: isActive ? const Color(0xFF469BFF) : const Color(0xFF909090),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? const Color(0xFF469BFF) : const Color(0xFF909090),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageNavItem(String imagePath, String label, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isActive)
              Container(
                height: 2.h,
                width: 24.w,
                color: const Color(0xFF469BFF),
              ),
            SizedBox(height: isActive ? 4.h : 6.h),
            Image.asset(
              imagePath,
              width: 24.w,
              height: 24.h,
              color: isActive ? const Color(0xFF469BFF) : const Color(0xFF909090),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? const Color(0xFF2A2A2A) : const Color(0xFF909090),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterItem(String imagePath, String label, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isActive)
              Container(
                height: 2.h,
                width: 24.w,
                color: const Color(0xFF469BFF),
              ),
            SizedBox(height: isActive ? 4.h : 6.h),
            Image.asset(
              imagePath,
              width: 24.w,
              height: 24.h,
              color: isActive ? const Color(0xFF469BFF) : const Color(0xFF909090),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? const Color(0xFF2A2A2A) : const Color(0xFF909090),
              ),
            ),
          ],
        ),
      ),
    );
  }
}