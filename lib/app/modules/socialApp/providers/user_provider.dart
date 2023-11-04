import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/database/connect/base_connect.dart';

import '../models/user_model.dart';

class SocialUserProvider extends BaseConnect {
  static const String _tableName = 'users';
  GetStorage socialAppUserBox = GetStorage();
  SocialUserProvider._();
  static SocialUserProvider? _instance;
  static SocialUserProvider get instance {
    _instance ??= SocialUserProvider._();
    return _instance!;
  }

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SocialAppUser.fromJson(map);
      if (map is List) {
        return map.map((item) => SocialAppUser.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SocialAppUser?> getUser(int id) async {
    final response = await get('user/$id');
    return response.body;
  }

  Future<Response<SocialAppUser>> postUser(SocialAppUser user) async =>
      await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');

  /// all social app accounts
  List<SocialAppUser> users = [];

  Future<List<SocialAppUser>> getAllUsers() async {
    try {
      final data =
          jsonDecode(socialAppUserBox.read('_tableName') ?? '[]') as List;
      users = data.map((e) => SocialAppUser.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log('getAllUsers error: $e');
    }
    return users;
  }

  /// store new user in users in local storage
  Future<void> storeNewUser(SocialAppUser user) async {
    try {
      List<SocialAppUser> users = await getAllUsers();
      users.add(user);
      await socialAppUserBox.write(
          '_tableName', jsonEncode(users.map((e) => e.toJson()).toList()));
      await getAllUsers();
    } catch (e) {
      log('storeNewUser error: $e');
    }
  }

  /// update user in users in local storage
  Future<void> updateUser(SocialAppUser user) async {
    List<SocialAppUser> users = await getAllUsers();
    users[users.indexWhere((element) => element.id == user.id)] = user;
    await socialAppUserBox.write(
        'user', jsonEncode(users.map((e) => e.toJson()).toList()));
  }

  /// delete user in users in local storage
  Future<void> deleteUserFromStorage(int id) async {
    List<SocialAppUser> users = await getAllUsers();
    users.removeWhere((element) => element.id == id);
    await socialAppUserBox.write(
        'user', jsonEncode(users.map((e) => e.toJson()).toList()));
  }

  /// get user from users in local storage
  Future<SocialAppUser?> getUserFromStorage(int? id) async {
    List<SocialAppUser> users = await getAllUsers();
    return users.firstWhereOrNull((element) => element.id == id);
  }
}
