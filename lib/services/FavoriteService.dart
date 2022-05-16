import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/DeviceModel.dart';

Future<List<DeviceModel>> FavoriteService() async {
  final String url = Host + "/api/favorite";
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<dynamic> updateFavoriteService(String id, bool favorite) async {
  try {
    final String url = Host + "/api/favorite";
    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "favorite": favorite,
      }),
    );
    return "success";
  } catch (e) {
    print(e);
  }
}
