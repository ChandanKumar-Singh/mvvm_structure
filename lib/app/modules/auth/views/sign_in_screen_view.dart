import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SignInScreenView extends GetView {
  const SignInScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignInScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SignInScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
