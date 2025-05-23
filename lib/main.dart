import 'package:dentilligence/View/SplashScreen/splash_screen.dart';
import 'package:dentilligence/constance/storage_service.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  StorageService languagePreferences = StorageService();
  String? savedLanguageCode = await languagePreferences.getSelectedLanguageCode();

  runApp(MyApp(savedLanguageCode: savedLanguageCode));
}

class MyApp extends StatelessWidget {
    final String? savedLanguageCode;

  MyApp({this.savedLanguageCode});
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit( 
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
  
   builder: (context, child) {
        return GetMaterialApp(
      debugShowCheckedModeBanner: false,
            localizationsDelegates:  [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('mr'), // Marathi
            Locale('bn'), // Bengali
          ],
          locale: savedLanguageCode != null 
              ? Locale(savedLanguageCode!)
              : const Locale('en'),
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      home:SplashScreen()           //HomePage(),
   );
   }
    );
  }
}



// ignore: must_be_immutable
class Flare extends StatefulWidget {
  String animation = 'still';
  Flare({required this.animation});
  @override
  _FlareState createState() => _FlareState();
}

class _FlareState extends State<Flare> {
  @override
  Widget build(BuildContext context) {
    return FlareActor(
      "assets/Imgaes/DiceRoll.flr",
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      animation: widget.animation,
    );
  }
}