import 'dart:async';

import 'package:flutter/material.dart';
import '/models/user_model.dart';

/// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({super.key, required super.child})
      : super(notifier: StreamAuthNotifier());

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}

/// A class that converts [StreamAuth] into a [ChangeNotifier].
class StreamAuthNotifier extends ChangeNotifier {
  /// Creates a [StreamAuthNotifier].
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((UserModel? user) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final StreamAuth streamAuth;
}

/// A class that manages the [authentication] of the user. It also provides a [stream] that notifies when the current user has changed.
class StreamAuth {
  /// The interval that automatically signs out the user.
  final int refreshInterval;

  /// Creates an [StreamAuth] that clear the current user session in
  /// [refeshInterval] second.
  StreamAuth({this.refreshInterval = 20})
      : _userStreamController = StreamController<UserModel?>.broadcast() {
    _userStreamController.stream.listen((UserModel? currentUser) {
      _currentUser = currentUser;
    });
  }

  /// The current user.
  UserModel? get currentUser => _currentUser;
  UserModel? _currentUser;

  /// A stream that notifies when current user has changed.
  Stream<UserModel?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<UserModel?> _userStreamController;

  // check if user is signed in
  Future<(bool, UserModel?)> isSignedIn() async {
    bool isSignedIn = false;
    UserModel? user;
    user = await _handleIsSignIn();
    return (isSignedIn, user);
  }

  //sign in
  Future<bool?> signIn(UserModel user) async {
    try {
      return await _handleSignIn(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<bool?> signOut() async {
    try {
      return await _handleSignOut();
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future<bool> _handleSignIn(UserModel user) async => true;

  Future<UserModel?> _handleIsSignIn() async => null;

  Future<bool> _handleSignOut() async => true;
}
