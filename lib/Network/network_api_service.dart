import 'dart:convert';
import 'dart:io';

import 'package:dentilligence/Exception/exception.dart';
import 'package:dentilligence/Network/base_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic returnResponse(http.Response response) {
    print('Raw Response Body: ${response.body}');
    final responseBody = jsonDecode(response.body);
    final message = responseBody['message'] ?? 'Unknown error occurred';

    switch (response.statusCode) {
      case 200:
        return responseBody;
      default:
        throw message;
    }
  }

  /// GET API method
  @override
  Future<dynamic> getApi(String url,
      {Map<String, dynamic>? data, String? authToken}) async {
    if (kDebugMode) {
      print('API URL: $url');
      print('Request Params: $data');
      print('AuthToken: $authToken');
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      Uri uri = Uri.parse(url);

      // Format query params correctly
      if (data != null && data.isNotEmpty) {
        final queryParameters = <String, dynamic>{};

        data.forEach((key, value) {
          if (value is List) {
            // for (var item in value) {
            //   queryParameters[key] = item.toString();
            // }
            queryParameters[key] =
                value.map((item) => item.toString()).toList();
          } else if (value != null) {
            queryParameters[key] = value.toString();
          }
        });

        uri = uri.replace(queryParameters: queryParameters);
      }

      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print('Final API URL: $uri');
        print('Response: ${response.body}');
      }

      return returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }

  /// POST API method
  @override
  Future<dynamic> postApi(
    dynamic data,
    String url, {
    Map<String, dynamic>? query,
    String? authToken,
  }) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Payload: $data');
      print('Query Params: $query');
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      // Build URI with query parameters
      Uri uri = Uri.parse(url);
      if (query != null && query.isNotEmpty) {
        uri = uri.replace(
            queryParameters: query.map(
          (key, value) => MapEntry(
              key,
              value is List
                  ? value.map((e) => e.toString()).join(',')
                  : value.toString()),
        ));
      }

      final response = await http
          .post(
            uri,
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 180));

      if (kDebugMode) {
        print('Final URL: ${uri.toString()}');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      return returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      print(e);
      throw '$e';
    }
  }

  /// PUT API method
  @override
  Future<dynamic> putApi(var data, String url, {String? authToken}) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Payload: $data');
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      final response = await http
          .put(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      return returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }

  /// DELETE API method
  @override
  Future<dynamic> deletetApi(var data, String url, {String? authToken}) async {
    if (kDebugMode) {
      print('API URL: $url');
    }

    try {
      final headers = {
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print('Response: ${response.body}');
      }

      return returnResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }

  /// Multipart POST API method for file uploads
  @override
  Future<dynamic> multipartPostApi(
    String url, {
    required Map<String, String> fields,
    required Map<String, String> files,
    String? authToken,
  }) async {
    if (kDebugMode) {
      print('Multipart API URL: $url');
      print('Fields: $fields');
      print('Files: $files');
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Content-Type'] = 'multipart/form-data';
      if (authToken != null) {
        request.headers['Authorization'] = 'Bearer $authToken';
      }
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      await Future.forEach(files.entries, (entry) async {
        final file = File(entry.value);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              file.path,
            ),
          );
        }
      });

      final response =
          await request.send().timeout(const Duration(seconds: 30));

      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);

      if (kDebugMode) {
        print('Multipart Response Status: ${response.statusCode}');
        print('Multipart Response Body: $jsonResponse');
      }

      return returnResponse(http.Response(responseData, response.statusCode));
    } on SocketException {
      throw 'No Internet connection';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }

// Multipart POST API method for file uploads with XFile support
  Future<dynamic> multipartPostApiWithXFile(
    String url, {
    required Map<String, String> fields,
    required Map<String, XFile> files,
    String? authToken,
  }) async {
    if (kDebugMode) {
      print('Multipart API URL: $url');
      print('Fields: $fields');
      print('Files: $files');
    }

    try {
      final headers = {
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      await Future.wait(files.entries.map((entry) async {
        final file = entry.value;
        final stream = http.ByteStream(Stream.castFrom(file.openRead()));
        final length = await file.length();
        final multipartFile = http.MultipartFile(
          entry.key,
          stream,
          length,
          filename: file.name,
        );
        request.files.add(multipartFile);
      }));

      final response =
          await request.send().timeout(const Duration(seconds: 180));
      final responseString = await response.stream.bytesToString();

      if (kDebugMode) {
        print('Status Code: ${response.statusCode}');
        print('Response Body: $responseString');
      }

      return returnResponse(http.Response(responseString, response.statusCode));
    } on SocketException {
      throw 'No Internet connection';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }
}
