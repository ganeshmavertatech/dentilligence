import 'package:dentilligence/View/Onboardings%20screen/onboarding_first_screen.dart';
import 'package:dentilligence/constance/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  void _changeLanguage(Locale locale) async {
    Get.updateLocale(locale);
    await StorageService().setSelectedLanguageCode(locale.languageCode);
  }
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Center(
              child:Image.asset('assets/Icons/logo.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
            ),
            SizedBox(height: 20),
           Center(
            child:  Text(
              "Choose Your\nPreferred Language",
               style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Corben',
                  height: 36 / 26,
                  color: Color(0xFF252525),
                ),
                textAlign: TextAlign.center,
            ),
           ),
            SizedBox(height: 30),
            LanguageOption(
              iconPath: 'assets/Icons/english_icon.png',
              language: 'English',
              isSelected: selectedLanguage == 'English',
              onTap: () {
                setState(() {
                  selectedLanguage = 'English';
                  _changeLanguage(Locale('en', 'US'));
                });
                navigateToNextPage();
              },
            ),
            LanguageOption(
              iconPath: 'assets/Icons/hindi_icon.png',
              language: 'Hindi',
              isSelected: selectedLanguage == 'Hindi',
              onTap: () {
                setState(() {
                  selectedLanguage = 'Hindi';
                 _changeLanguage(Locale('mr', 'IN'));
                });
                navigateToNextPage();
              },
            ),
            LanguageOption(
              iconPath: 'assets/Icons/uk-language-icon.png',
              language: 'Ukrainian',
              isSelected: selectedLanguage == 'Ukrainian',
              onTap: () {
                setState(() {
                  selectedLanguage = 'Ukrainian';
                 _changeLanguage(Locale('bn', 'BD'));
                });
                navigateToNextPage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateToNextPage() async{
    await Future.delayed(Duration(milliseconds: 200));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>OnboardingScreen(),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String iconPath;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  LanguageOption({
    required this.iconPath,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF469BFF).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
            width: isSelected ? 0 : 1,
          ),
        ),
        child: ListTile(
          leading: Image.asset(
            iconPath,
            height: 20,
            width: 20,
            color: isSelected ? Colors.black : Colors.black,
          ),
          title: Text(
            language,
            style: GoogleFonts.lato(
              color: isSelected ? Colors.black : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: isSelected
              ? CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
