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

Future<dynamic> CreateAccountService(
  String name,
  String id,
  String email,
  String password,
  String phoneNo,
  String status,
  String access,
) async {
  try {
    final String url = Host + "/api/account";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'id': id,
        'email': email,
        'password': password,
        'phoneNo': phoneNo,
        'status': status,
        'access': access,
      }),
    );
    return "success";
  } catch (e) {
    print(e);
  }
}
