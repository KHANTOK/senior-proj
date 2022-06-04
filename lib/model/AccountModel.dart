// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

List<AccountModel> accountModelFromJson(String str) => List<AccountModel>.from(
    json.decode(str).map((x) => AccountModel.fromJson(x)));

String accountModelToJson(List<AccountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountModel {
  AccountModel({
    required this.email,
    required this.name,
  });

  String email;
  String name;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
