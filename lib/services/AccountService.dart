import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/AccountModel.dart';

Future<AccountModel> LoginService(String email, String password) async {
  Map<String, dynamic> queryParameters = {
    'email': email,
    'password': password,
  };
  final uri = Uri.https(Host, '/login', queryParameters);
  final response = await http.get(
    uri,
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
    Map<String, dynamic> queryParameters = {
      'name': name,
      'id': id,
      'email': email,
      'password': password,
      'phoneNo': phoneNo,
      'status': status,
      'access': access,
    };
    final uri = Uri.https(Host, '/createAccount', queryParameters);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}
