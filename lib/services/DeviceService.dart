import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/DeviceDetailModel.dart';
import '../model/DeviceModel.dart';
import '../model/EditDeviceModel.dart';

Future<List<DeviceModel>> DeviceService() async {
  final uri = Uri.https(Host, '/devices');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<String> SaveDeviceFromAPIKKUService() async {
  final uri = Uri.https(Host, '/importDevices');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response.body;
}

Future<DeviceDetailModel> DeviceDetailService(String device) async {
  Map<String, dynamic> queryParameters = {
    'device': device,
  };
  final uri = Uri.https(Host, '/deviceDetail', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return DeviceDetailModel.fromJson(json.decode(response.body));
}

Future<List<DeviceModel>> DeviceFilterByFacultyService(String faculty) async {
  Map<String, dynamic> queryParameters = {
    'faculty': faculty,
  };
  final uri = Uri.https(Host, '/deviceFilterByFaculty', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<EditDeviceModel> EditDeviceCallAPIService(String bib_id) async {
  Map<String, dynamic> queryParameters = {
    'bib_id': bib_id,
  };
  final uri = Uri.https(Host, '/deviceByBIBID', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return EditDeviceModel.fromJson(json.decode(response.body));
}

Future<dynamic> updateDeviceService(String bib_id, String device_name,
    String accession, String duration) async {
  Map<String, dynamic> queryParameters = {
    'bib_id': bib_id,
    'device_name': device_name,
    'accession': accession,
    'duration': duration,
  };
  final uri = Uri.https(Host, '/update/device', queryParameters);
  final response = await http.get(
    uri,
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
