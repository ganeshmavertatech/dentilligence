import 'package:dentilligence/Network/network_api_service.dart';
import 'package:dentilligence/constance/api_constance.dart';

class RegistrationRepo {

  final _apiService= NetworkApiServices();

  Future<dynamic> registrations(var data) async{
    dynamic response=_apiService.postApi(data, ApiConstants.registrations);
    return response;
  }

    Future<dynamic> otpVerifyApi(var data) async{
    dynamic response=_apiService.postApi(data, ApiConstants.OtpVerifypoint);
    return response;
  }
}