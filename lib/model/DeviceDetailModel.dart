// To parse this JSON data, do
//
//     final deviceDetailModel = deviceDetailModelFromJson(jsonString);

import 'dart:convert';

DeviceDetailModel deviceDetailModelFromJson(String str) =>
    DeviceDetailModel.fromJson(json.decode(str));

String deviceDetailModelToJson(DeviceDetailModel data) =>
    json.encode(data.toJson());

class DeviceDetailModel {
  DeviceDetailModel({
    required this.id,
    required this.description,
    required this.accession,
    required this.location,
  });

  String id;
  String description;
  String accession;
  List<Location> location;

  factory DeviceDetailModel.fromJson(Map<String, dynamic> json) =>
      DeviceDetailModel(
        id: json["id"],
        description: json["description"],
        accession: json["accession"],
        location: List<Location>.from(
            json["location"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "accession": accession,
        "location": List<dynamic>.from(location.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    required this.locationName,
    required this.count,
  });

  String locationName;
  int count;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationName: json["locationName"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "locationName": locationName,
        "count": count,
      };
}
