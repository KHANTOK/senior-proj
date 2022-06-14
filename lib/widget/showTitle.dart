import 'package:flutter/material.dart';
import 'package:proj/color.dart';

Widget showTitle(double size) {
  return ListTile(
    title: Text(
      "อุปกรณ์ที่สามารถยืมได้",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    ),
    subtitle: Text(
      "มหาวิทยาลัยขอนแก่น",
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: size),
    ),
  );
}
