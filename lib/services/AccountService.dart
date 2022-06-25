import 'dart:convert';

import 'package:http/http.dart' as http;
import '../http/client.dart';
import '../model/AccountModel.dart';

Future<AccountModel> LoginService(String email, String password) async {
  final String url = Host + "/login/?email=" + email + "&password=" + password;
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
  String email,
) async {
  try {
    final String url =
        Host + "/createAccount/?name=" + name + "&email=" + email;
    final response = await http.get(
      Uri.parse(url),
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
    final String url = Host + "/account";
    final response = await http.get(
      Uri.parse(url),
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
    final String url = Host + "/delete/account/?email=" + email;
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
