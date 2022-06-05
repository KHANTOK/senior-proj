import 'package:flutter/material.dart';
import 'package:proj/color.dart';

Widget showTitle() {
  return const ListTile(
    title: Text(
      "อุปกรณ์ที่สามารถยืมได้",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    subtitle: Text(
      "มหาวิทยาลัยขอนแก่น",
      style: TextStyle(
          color: kPrimaryLightColor, fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}
