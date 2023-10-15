import 'package:dio/dio.dart';
import '/core/dio/dio_client.dart';

import '../core/dio/base/api_response.dart';
import '../core/dio/exception/api_error_handler.dart';

class DashRepo {
  final DioClient dioClient;
  // final SharedPreferences sharedPreferences;
  DashRepo({
    required this.dioClient,
    // required this.sharedPreferences,
  });

  Future<ApiResponse> hitApi(
    String endPoint, {
    bool token = true,
    Map<String, dynamic>? data,
    FormData? formData,
    RequestType requestType = RequestType.post,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      late Response response;
      switch (requestType) {
        case RequestType.get:
          response = await dioClient.get(endPoint,
              token: token, queryParameters: queryParameters);
          break;
        case RequestType.post:
          response = await dioClient.post(
            endPoint,
            data: data,
            token: token,
            formData: formData,
            queryParameters: queryParameters,
          );
          break;
        case RequestType.put:
          response = await dioClient.put(endPoint,
              data: data, queryParameters: queryParameters);
          break;
        case RequestType.delete:
          response = await dioClient.delete(endPoint,
              queryParameters: queryParameters, data: data);
          break;
      }
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///:register
  Future<ApiResponse> getCoins() async =>
      await hitApi('getCoins', token: true, requestType: RequestType.get);

  Future<ApiResponse> verifyMnemonic(Map<String, dynamic> data) async =>
      await hitApi('verifyMnemonic', token: true, data: data);
}
