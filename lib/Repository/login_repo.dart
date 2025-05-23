import 'package:dentilligence/Network/network_api_service.dart';
import 'package:dentilligence/constance/api_constance.dart';

class LoginRepo {

  final _apiService= NetworkApiServices();

   Future<dynamic> loginApi(var data) async{
    dynamic response=_apiService.postApi(data, ApiConstants.loginApi);
    return response;
  }

    Future<dynamic> otpVerifyApi(var data) async{
    dynamic response=_apiService.postApi(data, ApiConstants.OtpVerifypoint);
    return response;
  }
}