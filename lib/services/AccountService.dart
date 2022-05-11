import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/AccountModel.dart';

Future<AccountModel> LoginService(String email, String password) async {
  final String url = Host + "/api/account/" + email + "/" + password;
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return AccountModel.fromJson(jsonDecode(response.body));
}
