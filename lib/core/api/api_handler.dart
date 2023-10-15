import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import '/utils/my_logger.dart';

import '../dio/base/api_response.dart';
import '../dio/base/error_response.dart';

/// internet connection status ISONLINE
bool isOnline = true;

class ApiHandler {
  static const String _tag = 'ApiHandler';

  /// hit api
  static Future<(Map<String, dynamic>?, bool, bool)> hitApi(
    String tag,
    String endPoint,
    Future<ApiResponse> Function() method, {
    bool cache = false,
  }) async {
    /// check if cache exist
    bool cacheExist = await APICacheManager().isAPICacheKeyExist(endPoint);

    /// data will be stored here
    Map<String, dynamic>? map;

    /// status of response or retrieved data
    bool status = false;

    logger.i('cache exist $endPoint $cacheExist $cache', tag: _tag);

    /// if online
    if (isOnline) {
      ApiResponse apiResponse = await method();
      if (apiResponse.response != null) {
        map = apiResponse.response!.data;

        /// if status code is 200 || less than 300 , then status is true
        if ((apiResponse.response!.statusCode ?? 0) >= 200 &&
            (apiResponse.response!.statusCode ?? 0) < 300) {
          try {
            status = map?["status"] ?? false;
          } catch (e) {
            logger.e('$endPoint status could not be retrieved $e', tag: _tag);
          }
          try {
            if (status) {
              if (map != null && cache) {
                /// add data to cache
                var cacheModel =
                    APICacheDBModel(key: endPoint, syncData: jsonEncode(map));
                await APICacheManager().addCacheData(cacheModel);
                logger.i('cache added $endPoint', tag: _tag);
              }
            }
          } catch (e) {
            logger.e('$endPoint could not add cache $e', tag: _tag);
          }
        }

        /// if status code is greater than 300 , then response error
        else {
          //implement error handling

          return (map, status, cacheExist);
        }
      } else {
        //implement error handling
        checkResponseError(apiResponse);
        return (map, status, cacheExist);
      }
    }

    ///not online and cache exist and data retrieve from cache allowed
    else if (!isOnline && cacheExist && cache) {
      var data = (await APICacheManager().getCacheData(endPoint)).syncData;
      try {
        map = jsonDecode(data);
        status = true;
        return (map, status, cacheExist);
      } catch (e) {
        logger.e('$endPoint could not be decoded $e', tag: _tag);
        return (map, status, cacheExist);
      }
    }

    /// [not online and cache not exist or data retrieve from cache not allowed]
    else {
      //show toast
      // Toasts.showWarningNormalToast(Get.context!, 'You are offline. Retry!');
    }
    return (map, status, cacheExist);
  }

  /// check response error
  static void checkResponseError(ApiResponse apiResponse,
      {bool logout = false}) {
    if (apiResponse.error is! String &&
        apiResponse.error.errors[0].message == 'Unauthorized.') {
      if (logout) {
        //todo: clear auth data and others
        // sl.get<AuthProvider>().clearUser();
        // Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
        // Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();

        ///TODO: route to login screen on
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => LoginScreen()),
        //         (route) => false);
      }
    } else {
      handleUncaughtError(apiResponse);
    }
  }

  /// handle uncaught error
  static void handleUncaughtError(ApiResponse apiResponse,
      {bool showToast = true}) {
    String errMsg = "";
    if (apiResponse.error is String) {
      errMsg = apiResponse.error.toString();
    } else {
      ErrorResponse errorResponse = apiResponse.error;
      errMsg = errorResponse.errors[0].message;
    }
    logger.e(errMsg, tag: _tag);

    if (showToast) {
      //show toast
      // Toasts.showErrorNormalToast(context, errorMessage);
    }
  }
}
