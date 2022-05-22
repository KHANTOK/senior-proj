import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/DeviceModel.dart';

Future<List<DeviceModel>> FavoriteService() async {
  final uri = Uri.https(Host, '/favorite');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return List<DeviceModel>.from(
      json.decode(response.body).map((data) => DeviceModel.fromJson(data)));
}

Future<dynamic> updateFavoriteService(String device, String favorite) async {
  try {
    Map<String, dynamic> queryParameters = {
      "device": device,
      "favorite": favorite,
    };
    final uri = Uri.https(Host, '/update/favorite', queryParameters);
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
