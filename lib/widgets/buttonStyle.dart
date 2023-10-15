// ignore_for_file: file_names

import 'package:flutter/material.dart';

ButtonStyle buttonStyle({double radius = 10, Color? bgColor}) {
  return ElevatedButton.styleFrom().copyWith(
      shape: MaterialStateProperty.resolveWith(
        (states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      backgroundColor: MaterialStateProperty.resolveWith((states) => bgColor));
}
