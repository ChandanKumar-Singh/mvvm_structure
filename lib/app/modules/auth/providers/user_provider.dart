import '/database/connect/base_connect.dart';

import '../user_model.dart';

class UserProvider extends BaseConnect {
  Future<Users> getUser() async {
    final response = await get('user');
    if (response.statusCode == 200) {
      return Users.fromJson(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Users> updateUser(Users user) async {
    final response = await put('user/${user.id}', user.toJson());
    if (response.statusCode == 200) {
      return Users.fromJson(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<Users> deleteUser(int id) async {
    final response = await delete('user/$id');
    if (response.statusCode == 200) {
      return Users.fromJson(response.body);
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
