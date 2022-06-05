// To parse this JSON data, do
//
//     final editDeviceModel = editDeviceModelFromJson(jsonString);

import 'dart:convert';

EditDeviceModel editDeviceModelFromJson(String str) =>
    EditDeviceModel.fromJson(json.decode(str));

String editDeviceModelToJson(EditDeviceModel data) =>
    json.encode(data.toJson());

class EditDeviceModel {
  EditDeviceModel({
    required this.bibId,
    required this.deviceName,
  });

  String bibId;
  String deviceName;

  factory EditDeviceModel.fromJson(Map<String, dynamic> json) =>
      EditDeviceModel(
        bibId: json["bib_id"],
        deviceName: json["device_name"],
      );

  Map<String, dynamic> toJson() => {
        "bib_id": bibId,
        "device_name": deviceName,
      };
}
