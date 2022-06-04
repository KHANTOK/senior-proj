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
  String email,
) async {
  try {
    Map<String, dynamic> queryParameters = {
      'name': name,
      'email': email,
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

Future<dynamic> GetAccountService() async {
  try {
    final uri = Uri.https(Host, '/account');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return List<AccountModel>.from(
        json.decode(response.body).map((x) => AccountModel.fromJson(x)));
  } catch (e) {
    print(e);
  }
}

Future<dynamic> DeleteAccountService(
  String email,
) async {
  try {
    Map<String, dynamic> queryParameters = {
      'email': email,
    };
    final uri = Uri.https(Host, '/delete/account', queryParameters);
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
