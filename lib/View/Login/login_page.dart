import 'package:dentilligence/View/Login/otp_verification.dart';
import 'package:dentilligence/constance/colors_constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Controller/login_controller.dart';
import '../Sign Up/sign_up_page.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
final LoginController _controller=Get.put(LoginController());
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
              padding: EdgeInsets.symmetric(horizontal: 30),
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
                    AppLocalizations.of(context)!.signIn,
                    style: GoogleFonts.corben(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                   Text(
                    AppLocalizations.of(context)!.signInDescription,
                     style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Email field
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _controller.emialController,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset('assets/Icons/mage_email.png',height: 16,width: 16,color: Colors.black,),
                      labelText: AppLocalizations.of(context)!.emailAddress,
                      labelStyle: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w400,color: ColorsConstants.textPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        _controller.loginApi(context,showSuccessPopup: true,showErrorPopup: true);
                        // Navigator.push(context,MaterialPageRoute(
                        //   builder: (context) => VerifyOtpPage(),
                        // ));
                      },
                      child: Text(AppLocalizations.of(context)!.continueText,
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
                  SizedBox(height: 50),

                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(AppLocalizations.of(context)!.or),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Don't have account? and Sign Up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.dontHaveAccount,
                      style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),),
                    ],
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                      },
                      child: Text(AppLocalizations.of(context)!.signUp,
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
