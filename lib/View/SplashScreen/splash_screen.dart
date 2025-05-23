import 'package:dentilligence/View/Langauge%20screen/langauge_select_page.dart';
import 'package:dentilligence/constance/Image_assets.dart';
import 'package:dentilligence/constance/storage_service.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final String? backgroundNotification;

  SplashScreen({this.backgroundNotification});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _disposed = false; 

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

Future<void> checkLoginStatus() async {
  await Future.delayed(Duration(seconds: 2));
  if (!_disposed) {
    try {
      String? authToken = StorageService.getSessionToken();
      String? role = StorageService.getRole();

      if (authToken != null && authToken.isNotEmpty) {
        if (role == "Buyer") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
          );
        } else if (role == "Seller") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
        );
      }
    } catch (error) {
      print("Error from SplashScreen: $error");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
      );
    }
  }
}


  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  // static clearPreferences() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.clear();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ImageAssets.splashScreen,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return Center(
                child: Text(
                  'Image Error',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}




