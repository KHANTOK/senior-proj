// To parse this JSON data, do
//
//     final manageDeviceModel = manageDeviceModelFromJson(jsonString);

import 'dart:convert';

List<ManageDeviceModel> manageDeviceModelFromJson(String str) =>
    List<ManageDeviceModel>.from(
        json.decode(str).map((x) => ManageDeviceModel.fromJson(x)));

String manageDeviceModelToJson(List<ManageDeviceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManageDeviceModel {
  ManageDeviceModel({
    required this.bibId,
    required this.deviceName,
    required this.image,
    required this.accession,
    required this.duration,
    required this.unlock,
  });

  String bibId;
  String deviceName;
  String image;
  String accession;
  String duration;
  String unlock;

  factory ManageDeviceModel.fromJson(Map<String, dynamic> json) =>
      ManageDeviceModel(
        bibId: json["bib_id"],
        deviceName: json["device_name"],
        image: json["image"],
        accession: json["accession"],
        duration: json["duration"],
        unlock: json["unlock"],
      );

  Map<String, dynamic> toJson() => {
        "bib_id": bibId,
        "device_name": deviceName,
        "image": image,
        "accession": accession,
        "duration": duration,
        "unlock": unlock,
      };
}
