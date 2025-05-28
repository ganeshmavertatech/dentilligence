import 'package:dentilligence/Network/network_api_service.dart';
import 'package:dentilligence/constance/api_constance.dart';
import 'package:image_picker/image_picker.dart';

class FindingsRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> uploadFindings({
    required XFile smileFace,
    required XFile lowerJaw,
    required XFile upperJaw,
    String? authToken,
  }) async {
    try {
      final response = await _apiService.multipartPostApi(
        ApiConstants.findingsEndpoint,
        fields: {},
        files: {
          'smileFace': smileFace.path,
          'lowerJaw': lowerJaw.path,
          'upperJaw': upperJaw.path,
        },
        authToken: authToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}