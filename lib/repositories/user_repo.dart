import 'package:mvvm_structure/core/Database/database.dart';
import 'package:mvvm_structure/core/Database/firebase_database.dart';
import 'package:mvvm_structure/core/Database/hive_database.dart';
import 'package:mvvm_structure/core/Database/rest_api_database.dart';
import 'package:mvvm_structure/core/Database/shared_preferences_database.dart';
import 'package:mvvm_structure/core/Database/sql_database.dart';
import 'package:mvvm_structure/models/app_user_model.dart';
import 'package:mvvm_structure/models/user_model.dart';

class UserRepository {
  final Database db;

  UserRepository({required this.db}) {
    if (!db.isInitialized) {
      db.init();
    }
  }

  Future<UserModel> getUser() async {
    // return await db.getUser();
    if (db is FirebaseDatabase) {
      //get user from firebase
    } else if (db is HiveDatabase) {
      //get user from hive
    } else if (db is SQLDatabase) {
      //get user from SQLDatabase
    } else if (db is RestApiDatabase) {
      //get user from RestApiDatabase
    } else if (db is SPDatabase) {
      //get user from SPDatabase
    } else {
      //get user from any other database
    }
    return AppUser(id: 'id');
  }

  Future<bool> saveUser(UserModel user) async {
    // return await db.saveUser(user);

    if (db is FirebaseDatabase) {
      //save user to firebase
    } else if (db is HiveDatabase) {
      //save user to hive
    } else if (db is SQLDatabase) {
      //save user to SQLDatabase
    } else if (db is RestApiDatabase) {
      //save user to RestApiDatabase
    } else if (db is SPDatabase) {
      //save user to SPDatabase
    } else {
      //save user to any other database
    }

    return true;
  }

  Future<bool> deleteUser() async {
    // return await db.deleteUser();
    if (db is FirebaseDatabase) {
      //delete user from firebase
    } else if (db is HiveDatabase) {
      //delete user from hive
    } else if (db is SQLDatabase) {
      //delete user from SQLDatabase
    } else if (db is RestApiDatabase) {
      //delete user from RestApiDatabase
    } else if (db is SPDatabase) {
      //delete user from SPDatabase
    } else {
      //delete user from any other database
    }

    return true;
  }

  Future<bool> updateUser(UserModel user) async {
    // return await db.updateUser(user);
    if (db is FirebaseDatabase) {
      //update user to firebase
    } else if (db is HiveDatabase) {
      //update user to hive
    } else if (db is SQLDatabase) {
      //update user to SQLDatabase
    } else if (db is RestApiDatabase) {
      //update user to RestApiDatabase
    } else if (db is SPDatabase) {
      //update user to SPDatabase
    } else {
      //update user to any other database
    }

    return true;
  }
}
