import 'package:dentilligence/Repository/registration_repo.dart';
import 'package:dentilligence/View/Sign%20Up/otp_verification_sign_up.dart';
import 'package:dentilligence/constance/custom_snackbar.dart';
import 'package:dentilligence/constance/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegistrationController extends GetxController {
  final _api = RegistrationRepo();
  
  //BUYER PERSONAL DETAILS FEILD
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

   //BUYER SELLER DETAILS FEILD
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopAddressController = TextEditingController();
  final TextEditingController shopOpeningDateController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController shopAreaController = TextEditingController();
  final TextEditingController shopActNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();

  bool agreedToTerms=false;
  String? pancardImage;  // Base64 encoded PAN card image
  String? shopImage;     // Base64 encoded Shop image
  String? panFileName;  // File name for PAN card image
  String? shopFileName;     // File name for Shop image
  bool Buyer = true;
  bool Seller=true;
  String? selectedStateId;
  String? selectedDistrictId;

    final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());





  void RegistrationsApi(BuildContext context,{bool showSuccessPopup = false, bool showErrorPopup = true,}) {
    print(agreedToTerms);
    Map<String, String> data = {
    "first_name": firstNameController.text,
    "last_name": firstNameController.text,
    "email": emailController.text,
    "password": pinCodeController.text,
    "gender": "male",
    "mobile": mobileNumberController.text,
    "location": "India",
    "language": "English",
    "latitude": "12'12",
    "longitude": "13.12",
    "mode_of_registration": "online",
    "photo_url": "abc",
    "city": "Pune",
    "state": "Maharashtra",
    "country": "India",
    "ethinicity": "eastern",
    "status": "active",
    "role_name":"admin",
    "send_otp_to": "email"
    };
    _api.registrations(data).then((value) {
     String successMessage = value['message'] ?? 'Operation successful';
  if (value['status'] == '200') {
    if (showSuccessPopup) {
        CustomSnackbar.showSnackbar(context, successMessage);
      }
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => SignUpVerifyOtpPage(email:emailController.text)),
        (route) => false);
       
    });
  } 
  }).catchError((error) {
    if(showErrorPopup)
    CustomSnackbar.showSnackbar(context,error.toString(), isError: true);
  });
}

void otpVerifyApi(BuildContext context,String email, {bool showSuccessPopup = false, bool showErrorPopup = true,}) async {
  Map<String, String> data = {
    'email': email,
    'otp': otpControllers.map((controller) => controller.text).join(),
  };
_api.otpVerifyApi(data).then((value) async {
//  String successMessage = value['message'] ?? 'Operation successful';
//   if (value['status'] == '200') {
//     if (showSuccessPopup) {
//         CustomSnackbar.showSnackbar(context, successMessage);
//       }
//     Future.delayed(const Duration(seconds: 0), () {
//       // Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationSuccessPage(),));
//       String? role=StorageService.getRole();
      
//     });
//   }

    if (value['status'] == '200' && value['result'] != null) {
      String? sessionToken = value['result']['session-token'];
      String? userId=value['result']['user_id'];
      // String? role=value['result']['role']['name'];
      // String? firstName=value['result']['firstName'];
      // String? lastName=value['result']['lastName'];
      // String? mobile=value['result']['mobile'];
      // String? email=value['result']['email'];

      if (sessionToken != null) {
        await StorageService.saveSessionToken(sessionToken);
        print('Session Token Stored: $sessionToken');
      }

      if(userId != null){
        await StorageService.saveUserId(userId);
        print('User id get :-$userId');
      }

      // if(role != null){
      //   await StorageService.saveRole(role);
      //   print(role);
      // }
      
      // if(mobile != null){
      //   await StorageService.saveUserMobile(mobile);
      //   print(mobile);
      // }
      // if(email != null){
      //   await StorageService.saveUserEmail(email);
      //   print(email);
      // }
    }
  }).catchError((error) {
    if (showErrorPopup) {
      CustomSnackbar.showSnackbar(
        context,
        error.toString(),
        isError: true,
      );
    }
  });
}
}
