import 'dart:convert';

import '../http/client.dart';
import 'package:http/http.dart' as http;
import '../model/ManageDeviceModel.dart';

Future<List<ManageDeviceModel>> DeviceAllService() async {
  final uri = Uri.https(Host, '/devicesAll');
  final response = await http.get(
    uri,
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
    Map<String, dynamic> queryParameters = {
      "device": device,
      "unlock": unlock,
    };
    final uri = Uri.https(Host, '/update/unlock', queryParameters);
    final response = await http.get(
      uri,
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
  Map<String, dynamic> queryParameters = {
    "bib_id": bib_id,
    "device_name": device_name,
    "accession": accession,
    "duration": duration,
  };
  final uri = Uri.https(Host, '/importOtherDevice', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return "success";
}

Future<dynamic> DeleteDeviceService(String bib_id) async {
  Map<String, dynamic> queryParameters = {
    "bib_id": bib_id,
  };
  final uri = Uri.https(Host, '/delete/device', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return "success";
}
