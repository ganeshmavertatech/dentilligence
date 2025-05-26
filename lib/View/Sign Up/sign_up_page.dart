import 'package:dentilligence/constance/colors_constance.dart';
import 'package:dentilligence/constance/custom_text_feild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../Controller/registration_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final RegistrationController _controller=Get.put(RegistrationController());
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-right corner image
          Positioned(
            top: 40,
            right: 8,
            child: Image.asset(
              'assets/Icons/top_corner_image.png',
              width: 300,
              height: 200,
              color: Colors.blue.withOpacity(0.15),
            ),
          ),

          // Main content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // Teeth image in center
                  Image.asset(
                    'assets/Icons/mdi_dentist.png',
                    width: 54,
                    height: 54,
                  ),
                  SizedBox(height:10),

                  // Sign In text
                  Text(
                    AppLocalizations.of(context)!.signUp,
                    style: GoogleFonts.corben(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),
                   Text(
                    AppLocalizations.of(context)!.signUpDescription,
                     style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomField(
            labelText: AppLocalizations.of(context)!.fullName,
            prefixIcon: Image.asset('assets/Icons/user.png',height: 16,width: 16,color: Colors.black,),
            controller: _controller.firstNameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Cannot be empty";
              } else if (value.startsWith(' ')) {
                return "Cannot start with a space";
              } else if (RegExp(r'\d').hasMatch(value)) {
                return "Numbers are not allowed";
              } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return "Special characters are not allowed";
              } else if (value.trim().length < 3) {
                return "Text must be at least 3 characters";
              }
              return null;
            },
          ),
                  SizedBox(height: 10),
            
                  // Email field
                  CustomField(
            labelText: AppLocalizations.of(context)!.emailAddress,
            controller: _controller.emailController,
            prefixIcon: Image.asset('assets/Icons/mage_email.png',height: 16,width: 16,color: Colors.black,),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Cannot be empty";
              } else if (value.startsWith(' ') || value.endsWith(' ')) {
                return "Cannot start or end with a space";
              } else if (!RegExp(
                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value)) {
                return "Enter a valid email address";
              }
              return null;
            },
          ),
           const SizedBox(height: 10),
          CustomField(
            labelText: AppLocalizations.of(context)!.mobileNumber,
            controller: _controller.mobileNumberController,
            prefixIcon: Image.asset('assets/Icons/mobile_icon.png',height: 16,width: 16,color: Colors.black,),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Cannot be empty";
              } else if (value.startsWith(' ') || value.endsWith(' ')) {
                return "Cannot start or end with a space";
              } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return "Enter a valid 10-digit mobile number";
              }
              return null;
            },
          ),
           const SizedBox(height: 10),
            CustomField(
            labelText: AppLocalizations.of(context)!.pinCode,
            controller: _controller.pinCodeController,
            prefixIcon: Image.asset('assets/Icons/pincode.png',height: 10,width: 10,color: Colors.black,),
            suffixIcon: Image.asset('assets/Icons/location.png',height: 10,width: 10,color: Colors.black,),
            keyboardType: TextInputType.number,
            maxLength: 6,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Cannot be empty";
              } else if (value.startsWith(' ')) {
                return "Cannot start with a space";
              }
              return null; // Validation passed
            },
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
               value: _controller.agreedToTerms,
                onChanged: (value) {
                  setState(() {
                    _controller.agreedToTerms = value!;
                  });
                },
                checkColor: Colors.white, // Color of the checkmark
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return ColorsConstants
                        .buttonColor; // Background color of the selected checkbox
                  }
                  return Colors
                      .white; // Background color of the unselected checkbox
                }),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.iAgree,
                    style: GoogleFonts.kanit(
                        color: ColorsConstants.textSecondaryColor, fontSize: 14),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.polcy,
                        style: GoogleFonts.kanit(
                          color: ColorsConstants.textPrimaryColor,
                          decoration:
                              TextDecoration.underline, // Underline style
                          fontWeight: FontWeight.normal,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.and,
                        style:
                            TextStyle(color: ColorsConstants.textSecondaryColor),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.terms,
                        style: GoogleFonts.kanit(
                          color: ColorsConstants.textPrimaryColor,
                          decoration:
                              TextDecoration.underline, // Underline style
                          fontWeight: FontWeight.normal,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Add navigation logic for Privacy Policy
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
                  SizedBox(height: 10),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        _controller.RegistrationsApi(context,showErrorPopup: true,showSuccessPopup: true);
                        // Navigator.push(context,MaterialPageRoute(
                        //   builder: (context) => SignUpVerifyOtpPage(),
                        // ));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.continueText,
                      style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                      
                      ),
                    style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsConstants.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(double.infinity, 60),
                          ),
                    ),
                  ),
                  SizedBox(height: 40),

                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          AppLocalizations.of(context)!.or,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: ColorsConstants.textSecondaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Don't have account? and Sign Up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: GoogleFonts.lato(
                      fontSize: 14,
                      color: ColorsConstants.textSecondaryColor,
                      fontWeight: FontWeight.w400,
                    ),),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signIn,
                      style: GoogleFonts.lato(
                      fontSize: 16,
                      color: ColorsConstants.buttonColor,
                      fontWeight: FontWeight.w700,
                    ),
                      
                      ),
                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: ColorsConstants.buttonColor,
                                width: 1,
                              ),
                            ),
                            minimumSize: Size(double.infinity, 60),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}