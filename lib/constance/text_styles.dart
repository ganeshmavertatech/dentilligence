import 'package:dentilligence/constance/colors_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // Heading Styles
  static TextStyle heading1 = GoogleFonts.gluten(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color:Color.fromRGBO(21, 21, 21, 1),
  );

  static TextStyle heading = GoogleFonts.gluten(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorsConstants.headingColor,
  );

  static TextStyle heading3 = GoogleFonts.gluten(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  // Body Text Styles
  static TextStyle blackText = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color:Color.fromRGBO(21, 21, 21, 1),
  );

  static TextStyle blackBoldText = GoogleFonts.gluten(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color:Color.fromRGBO(21, 21, 21, 1),
  );
  


  static TextStyle fontText = GoogleFonts.gluten(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color:Color.fromRGBO(21, 21, 21, 1),
  );

  static TextStyle colorText = GoogleFonts.gluten(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color:Color.fromRGBO(172, 125, 12, 1),
  );
  
  static TextStyle colorSubNormalText = GoogleFonts.gluten(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color:Color.fromRGBO(172, 125, 12, 1),
  );


  static TextStyle colornormalText = GoogleFonts.gluten(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color:Color.fromRGBO(172, 125, 12, 1),
  );

  static TextStyle greyText = GoogleFonts.gluten(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color:Color.fromRGBO(123, 123, 123, 1),
  );

  // Subtitle Styles
  static TextStyle subtitle = GoogleFonts.gluten(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  // Caption Style
  static TextStyle caption = GoogleFonts.gluten(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  // Button Text Style
  static TextStyle button = GoogleFonts.gluten(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color.fromRGBO(255, 255, 255, 1),
  );

  //Cards 
  static TextStyle mainTitle = GoogleFonts.gluten(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color:Color.fromRGBO(21, 21, 21, 1),
  );
  static TextStyle title = GoogleFonts.gluten(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color:Color.fromRGBO(21, 21, 21, 1),
  );
   static TextStyle feedbackTitle = GoogleFonts.gluten(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color:Color.fromRGBO(21, 21, 21, 1),
  );
   static TextStyle cardDetails = GoogleFonts.gluten(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color:Color.fromRGBO(123, 123, 123, 1),
  );

  static TextStyle feedback = GoogleFonts.gluten(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color:Color.fromRGBO(21, 21, 21, 1),
  );

  static TextStyle whiteText = GoogleFonts.gluten(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(255, 255, 255, 1),
  );

    static TextStyle search = GoogleFonts.gluten(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color:Color.fromRGBO(123, 123, 123, 1),
  );

  static TextStyle blueText = GoogleFonts.gluten(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(42, 202, 234, 1),
  );

}
