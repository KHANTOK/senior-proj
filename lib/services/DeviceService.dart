import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/DeviceDetailModel.dart';
import '../model/DeviceModel.dart';

Future<List<DeviceModel>> DeviceService() async {
  final String url = Host + "/api/device";
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<String> SaveDeviceFromAPIKKUService() async {
  final String url = Host + "/api/device";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response.body;
}

Future<DeviceDetailModel> DeviceDetailService(String id) async {
  final String url = Host + "/api/device/detail/" + id;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return DeviceDetailModel.fromJson(json.decode(response.body));
}
