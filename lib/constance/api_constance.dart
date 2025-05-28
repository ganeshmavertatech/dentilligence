class ApiConstants {
  
  static const String baseUrl = "https://dentilligence-api.avertastrategy.com/v1";

  //http://192.168.29.191:8080


  //Sign-in-up

  static const String registrations = "$baseUrl/register/user";

  static const String OtpVerifypoint="$baseUrl/user/validate-otp";

  static const String loginApi="$baseUrl/user/validate-email";

  // Findingds
static const String findingsEndpoint = "$baseUrl/findings";
static const String userFindingsEndpoint = "$baseUrl/findings/user";


}