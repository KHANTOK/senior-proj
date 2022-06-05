import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/model/AccountModel.dart';
import 'package:proj/screen/Admin/create_acc_screen.dart';
import 'package:proj/screen/Admin/home_screen.dart';

import '../../services/AccountService.dart';

class ManageAdminScreen extends StatefulWidget {
  final String name;
  final String email;
  const ManageAdminScreen({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<ManageAdminScreen> createState() => _ManageAdminScreenState();
}

class _ManageAdminScreenState extends State<ManageAdminScreen> {
  List<AccountModel> account = [];
  @override
  void initState() {
    super.initState();
    getAllAccount();
  }

  void reFresh() {
    getAllAccount();
  }

  void getAllAccount() async {
    var response = await GetAccountService();
    setState(() {
      account = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "จัดการผู้ดูแล",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeAdminScreen(
                name: widget.name,
                email: widget.email,
              );
            }));
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                children: <Widget>[
                  for (var i = 0; i < account.length; i++)
                    adminCard(account[i].name, account[i].email)
                ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateAccScreen(name: widget.name, email: widget.email),
            ),
          );
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget adminCard(String name, String email) {
    return Card(
      color: Colors.white,
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('การแจ้งเตือน'),
              content: Text('คุณต้องการลบ ' + name + ' หรือไม่'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                  child: const Text('ยกเลิก'),
                ),
                TextButton(
                  onPressed: () async {
                    await DeleteAccountService(email);
                    reFresh();
                    Navigator.pop(context, 'ลบ');
                  },
                  child: const Text('ยืนยัน'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
