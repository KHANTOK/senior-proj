import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/DeviceDetailModel.dart';
import '../model/DeviceModel.dart';

Future<List<DeviceModel>> DeviceService() async {
  final uri = Uri.https(Host, '/devices');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(response.body);
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
