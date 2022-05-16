// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

List<DeviceModel> deviceModelFromJson(String str) => List<DeviceModel>.from(
    json.decode(str).map((x) => DeviceModel.fromJson(x)));

String deviceModelToJson(List<DeviceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceModel {
  DeviceModel({
    required this.id,
    required this.image,
    required this.favorite,
    required this.totalAvailable,
  });

  String id;
  String image;
  bool favorite;
  int totalAvailable;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json["id"],
        image: json["image"],
        favorite: json["favorite"],
        totalAvailable: json["totalAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "favorite": favorite,
        "totalAvailable": totalAvailable,
      };
}
