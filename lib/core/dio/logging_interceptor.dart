import 'package:dio/dio.dart';
import '/utils/my_logger.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.f("<-- END HTTP",
        tag: "--> ${options.uri} ${options.method} ${options.path}",
        error: options.headers.toString());

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    logger.f("<-- END HTTP",
        tag:
            "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}",
        error: response.data.toString());
    // successLog(
    //     "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    // String responseAsString = response.data.toString();

    // if (responseAsString.length > maxCharactersPerLine) {
    //   int iterations = (responseAsString.length / maxCharactersPerLine).floor();
    //   for (int i = 0; i <= iterations; i++) {
    //     int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
    //     if (endingIndex > responseAsString.length) {
    //       endingIndex = responseAsString.length;
    //     }
    //     successLog(
    //         responseAsString.substring(i * maxCharactersPerLine, endingIndex));
    //   }
    // } else {
    //   successLog(responseAsString);
    // }
    // successLog("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e(err.type.toString(),
        tag:
            "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}  response-type: ${err.response?.runtimeType}}",
        error: ' extra :$err \n response: ${err.response}');

    // errorLog(
    //     "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}  response: ${err.response}  extra :${err} response-type: ${err.response?.runtimeType}}");
    // if (err.response != null) {
    //   Toasts.fToast(err.response?.data['msg'] ??
    //       err.response?.data['message'] ??
    //       'Something went wrong');
    // }
    return super.onError(err, handler);
  }
}
