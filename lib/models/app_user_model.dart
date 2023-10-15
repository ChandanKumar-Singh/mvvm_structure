import 'package:mvvm_structure/models/user_model.dart';

class AppUser extends UserModel {
  AppUser({required String id, String? token}) : super(id: id, token: token);
}
