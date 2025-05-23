import 'package:dentilligence/Games/monster_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageBottom extends StatefulWidget {
  const HomePageBottom({super.key});

  @override
  State<HomePageBottom> createState() => _HomePageBottomState();
}

class _HomePageBottomState extends State<HomePageBottom> {
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.white,
    ));
    return 
    Center(
      child: 
          ElevatedButton(
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameHubScreen()),
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(42, 202, 234, 1),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Click here to play Games",
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
    
      
    );
  }
}