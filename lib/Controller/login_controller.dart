import 'package:dentilligence/Repository/login_repo.dart';
import 'package:dentilligence/View/Login/otp_verification.dart';
import 'package:dentilligence/constance/custom_snackbar.dart';
import 'package:dentilligence/constance/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  final _api=LoginRepo();

  
  final emialController = TextEditingController();
    final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());



  void loginApi(BuildContext context,{bool showSuccessPopup = false,bool showErrorPopup = true}) {
  Map<String, String> data = {
    'email': emialController.text,
  };

 _api.loginApi(data).then((value) {
  String successMessage = value['message'] ?? 'Operation successful';
  if (value['status'] == '200') {
    CustomSnackbar.showSnackbar(context, successMessage);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOtpPage(
            email: emialController.text,
          ),
        ),
      );
    });
  } else {
    CustomSnackbar.showSnackbar(context,
      value['message'] ?? 'Something went wrong',
      isError: true,
    );
  }
}).catchError((error) {
  CustomSnackbar.showSnackbar(context,
    error.toString(),
    isError: true,
  );
});
}

void otpVerifyApi(BuildContext context,String email,{bool showSuccessPopup = false, bool showErrorPopup = true,}) async {
  Map<String, String> data = {
    'email': email,
    'otp': "111111"             // otpControllers.map((controller) => controller.text).join(),
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