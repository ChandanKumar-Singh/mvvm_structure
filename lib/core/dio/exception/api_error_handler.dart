import 'package:dio/dio.dart';
import '/utils/my_logger.dart';

import '../base/error_response.dart';

class ApiErrorHandler {
  static String tag = 'ApiErrorHandler';
  static dynamic getMessage(error) {
    dynamic errorDescription = "";

    if (error is DioException) {
      logger.e(error.runtimeType, tag: '$tag getMessage', error: error);
      try {
        if (error.response != null) {
          switch (error.response?.statusCode) {
            case 404:
              errorDescription = 'Request not found';
              break;
            case 500:
              errorDescription = 'Internal server error';
              break;
            case 503:
              errorDescription = error.response?.statusMessage;
              break;
            default:
              errorDescription = error.response?.data;
          }
          errorDescription = error.response?.data;
        } else if (DioExceptionType.values.contains(error.type)) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout";
              break;
            case DioExceptionType.unknown:
              errorDescription = "Connection failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription = "Receive timeout in connection ";
              break;
            case DioExceptionType.badCertificate:
              errorDescription =
                  "Error caused by an incorrect certificate as configured by ValidateCertificate";
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout in connection";
              break;
            case DioExceptionType.connectionError:
              errorDescription =
                  "Connection error or socket exception error in connection";
              break;
            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 404:
                  errorDescription = 'Request not found';
                case 500:
                  errorDescription = 'Internal server error';
                case 503:
                  errorDescription = error.response?.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response?.data);
                  if (errorResponse.errors.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription =
                        "Failed to load data - status code: ${error.response?.statusCode}";
                  }
              }
              break;
          }
        } else {
          errorDescription = "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    logger.e(errorDescription, tag: '$tag getMessage', error: error);
    return errorDescription;
  }
}
