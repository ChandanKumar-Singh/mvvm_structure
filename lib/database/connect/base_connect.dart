// base connect from get connect with error handling

import 'package:get/get.dart';

class BaseConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.example.com';
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.statusCode == 401) {
        // do something
      }
      return response;
    });
    httpClient.addAuthenticator<dynamic>((request) async {
      // request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
  }
}
