import 'package:flutter/material.dart';

class ColorsConstants {
  // Primary Colors
  static const Color primaryColor = Color(0xFF0A73FF); // Example blue color
  static const Color primaryLightColor = Color(0xFF5AA9FF);
  static const Color headingColor = Color.fromRGBO(43, 43, 43, 1);

 static const Gradient blueGradient = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(12, 202, 234, 1),Color.fromRGBO(153, 224, 243, 1),],);
  
  static const Gradient yellowGradient = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(255, 195, 32, 1),Color.fromRGBO(255, 229, 159, 1),],);



  // Secondary Colors
  static const Color secondaryColor = Color.fromRGBO(217, 217, 217, 1);
  static const Color secondaryLightColor = Color(0xFFFFD95A);
  static const Color secondaryDarkColor = Color(0xFFC77800);

  // Background Colors
  static const Color backgroundColor = Color.fromRGBO(255, 247, 228, 1); // Light gray
  static const Color OtpbackgroundColor = Color.fromRGBO(255, 247, 228, 1); // Light gray
  static const Color scaffoldBackgroundColor = Color(0xFFFFF7E4); // White

  // Text Colors
  static const Color textPrimaryColor = Color.fromRGBO(21, 21, 21, 1); // Dark gray
  static const Color textSecondaryColor = Color.fromRGBO(123, 123, 123, 1); // Medium gray
  static const Color textLightColor = Color.fromRGBO(255, 255, 255, 1); // Light gray

  // Border Colors
  static const Color borderColor = Color.fromRGBO(172, 125, 12, 1); // Light border gray

  // Error Colors
  static const Color errorColor = Color(0xFFD32F2F); // Red

  // Success Colors
  static const Color successColor = Color.fromRGBO(22, 149, 96, 1);
// Green

  // Warning Colors
  static const Color warningColor = Color(0xFFFBC02D); // Yellow

  // Info Colors
  static const Color infoColor = Color(0xFF0288D1); // Blue

  // Custom Accent Colors
  static const Color accentPink = Color(0xFFE91E63);
  static const Color accentPurple = Color(0xFF9C27B0);

   //button color
  static const Color buttonColor = Color.fromRGBO(70, 155, 255, 1); // Blue

  static const Color radio = Color.fromRGBO(177, 177, 177, 1);

}
