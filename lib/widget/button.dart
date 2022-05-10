import 'package:flutter/material.dart';

class AppsButton {
  static button({
    required String label,
    required Function() onPressed,
    // required color,
    required double height,
    required double width,
  }) {
    return Container(
      height: height,
      // 48,
      width: width,
      // 300,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      // color: color,
    );
  }
}