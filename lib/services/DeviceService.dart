import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/DeviceDetailModel.dart';
import '../model/DeviceModel.dart';
import '../model/EditDeviceModel.dart';

Future<List<DeviceModel>> DeviceService() async {
  final String url = Host + "/devices";
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<String> SaveDeviceFromAPIKKUService(
    String bib_id, String device_name) async {
  final String url = Host +
      "/importDevices/" +
      "?bib_id=" +
      bib_id +
      "&device_name=" +
      device_name;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response.body;
}

Future<DeviceDetailModel> DeviceDetailService(String device) async {
  final String url = Host + "/deviceDetail/?device=" + device;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return DeviceDetailModel.fromJson(json.decode(response.body));
}

Future<List<DeviceModel>> DeviceFilterByFacultyService(String faculty) async {
  final String url = Host + "/deviceFilterByFaculty/?faculty=" + faculty;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<EditDeviceModel> EditDeviceCallAPIService(String bib_id) async {
  final String url = Host + "/deviceByBIBID/?bib_id=" + bib_id;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return EditDeviceModel.fromJson(json.decode(response.body));
}

Future<dynamic> updateDeviceService(String bib_id, String device_name,
    String accession, String duration) async {
  final String url = Host +
      "/update/device/?bib_id=" +
      bib_id +
      "&device_name=" +
      device_name +
      "&accession=" +
      accession +
      "&duration=" +
      duration;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return "success";
  } else {
    return "fail";
  }
}
