import 'package:dentilligence/Bottom%20Bar/bottom_navigation_bar.dart' as custom_nav;
import 'package:dentilligence/constance/colors_constance.dart';
import 'package:dentilligence/constance/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOtpPage extends StatefulWidget {
  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _otpControllers = 
      List.generate(6, (_) => TextEditingController());
  bool _allFieldsFilled = false;

  @override
  void dispose() {
    for (var node in _focusNodes) node.dispose();
    for (var controller in _otpControllers) controller.dispose();
    super.dispose();
  }

  void _checkAllFieldsFilled() {
    setState(() {
      _allFieldsFilled = _otpControllers.every((c) => c.text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      // Background decoration
                      Positioned(
                        top: 40,
                        right: 8,
                        child: Opacity(
                          opacity: 0.15,
                          child: Image.asset(
                            'assets/Icons/top_corner_image.png',
                            width: 300,
                            height: 200,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      
                      // Main content
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: MediaQuery.of(context).viewInsets.bottom > 0 
                              ? 50 
                              : 150,
                          bottom: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Logo and title
                            Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/Icons/mdi_dentist.png',
                                    width: 54,
                                    height: 54,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "OTP Verification",
                                    style: GoogleFonts.corben(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: ColorsConstants.textPrimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "We have sent 6 digit verification code on your",
                                       style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorsConstants.textSecondaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' Abcdef123@gmail.com',
                                         style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: ColorsConstants.textPrimaryColor,
                                    ),
                                      ),
                                      TextSpan(
                                      text: " email address",
                                       style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorsConstants.textSecondaryColor,
                                    ),
                                      )
                                    ]
                                    )
                                  
                                    ),
                                  
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // OTP Input Fields
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(6, (index) => 
                                  _buildOtpBox(context, index)),
                            ),
                            
                            const SizedBox(height: 30),
                            
                            // Resend options
                            Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Handle resend OTP
                                  },
                                  child: Text(
                                    "Didn't get an code?",
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorsConstants.textSecondaryColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle resend OTP
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Resend Code",
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsConstants.textSecondaryColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' in 0:55 Sec',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: ColorsConstants.buttonColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const Spacer(),
                            
                            // Verify Button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _allFieldsFilled
                                      ? ColorsConstants.buttonColor
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: _allFieldsFilled
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => custom_nav.NavigationBar(),
                                          ),
                                        );
                                      }
                                    : null,
                                child: Text(
                                  "Verify",
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: ColorsConstants.textLightColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        focusNode: _focusNodes[index],
        controller: _otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        cursorColor: ColorsConstants.buttonColor,
        style: TextStyles.blackBoldText,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: _otpControllers[index].text.isNotEmpty || 
                    _focusNodes[index].hasFocus
              ? ColorsConstants.buttonColor.withOpacity(0.1)
              : ColorsConstants.textLightColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _focusNodes[index].hasFocus || _allFieldsFilled
                  ? ColorsConstants.buttonColor
                  : ColorsConstants.textSecondaryColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: ColorsConstants.buttonColor,
              width: 1,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
          _checkAllFieldsFilled();
        },
      ),
    );
  }
}

