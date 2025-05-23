import 'dart:convert';
import 'dart:io';

import 'package:dentilligence/Exception/exception.dart';
import 'package:dentilligence/Network/base_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


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
Future<dynamic> getApi(String url, {Map<String, dynamic>? data, String? authToken}) async {
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
          queryParameters[key] = value.map((item) => item.toString()).toList();

        } else if (value != null) {
          queryParameters[key] = value.toString();
        }
      });

      uri = uri.replace(queryParameters: queryParameters);
    }

    final response = await http.get(uri, headers: headers).timeout(const Duration(seconds: 10));

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
      uri = uri.replace(queryParameters: query.map(
        (key, value) => MapEntry(
          key, 
          value is List ? value.map((e) => e.toString()).join(',') : value.toString()
        ),
      ));
    }

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    ).timeout(const Duration(seconds: 180));

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
  Future<dynamic> deletetApi(var data,String url, {String? authToken}) async {
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
}
