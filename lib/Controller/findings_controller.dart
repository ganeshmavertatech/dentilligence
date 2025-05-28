import 'package:dentilligence/Exception/exception.dart';
import 'package:dentilligence/Repository/findings_repo.dart';
import 'package:dentilligence/View/Video%20file/get_consultation_ready.dart';
import 'package:dentilligence/constance/custom_snackbar.dart';
import 'package:dentilligence/constance/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FindingsController extends GetxController {
  final _api = FindingsRepository();
  final isLoading = false.obs;

  Future<void> uploadFindings({
    required XFile smileFace,
    required XFile lowerJaw,
    required XFile upperJaw,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      final authToken = await StorageService.getSessionToken();
      
      final response = await _api.uploadFindings(
        smileFace: smileFace,
        lowerJaw: lowerJaw,
        upperJaw: upperJaw,
        authToken: authToken,
      );

      if (response['status'] == '200') {
        CustomSnackbar.showSnackbar(
          context,
          response['message'] ?? 'Findings uploaded successfully',
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GetConsultationPage()));
        return response['result'];
      } 
      else {
        throw response['message'] ?? 'Failed to upload findings';
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        context,
        e.toString(),
        isError: true,
      );
      throw e;
    } finally {
      isLoading(false);
    }
  }
}