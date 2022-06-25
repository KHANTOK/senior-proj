import 'dart:convert';

import '../http/client.dart';
import 'package:http/http.dart' as http;
import '../model/ManageDeviceModel.dart';

Future<List<ManageDeviceModel>> DeviceAllService() async {
  final String url = Host + "/devicesAll";
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<ManageDeviceModel>.from(json
      .decode(response.body)
      .map((data) => ManageDeviceModel.fromJson(data)));
}

Future<dynamic> updateUnlockService(String device, String unlock) async {
  try {
    final String url =
        Host + "/update/unlock/?device=" + device + "&unlock=" + unlock;
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return "success";
  } catch (e) {
    print(e);
  }
}

Future<dynamic> ImportOtherDeviceService(String bib_id, String device_name,
    String accession, String duration) async {
  final String url = Host +
      "/importOtherDevice/?bib_id=" +
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
  return "success";
}

Future<dynamic> DeleteDeviceService(String bib_id) async {
  final String url = Host + "/delete/device/?bib_id=" + bib_id;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return "success";
}
