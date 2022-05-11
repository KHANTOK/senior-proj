// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNo,
    required this.access,
    required this.status,
  });

  String id;
  String email;
  String password;
  String name;
  String phoneNo;
  String access;
  String status;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        access: json["access"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "phoneNo": phoneNo,
        "access": access,
        "status": status,
      };
}
