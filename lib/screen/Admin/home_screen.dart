import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/create_acc_screen.dart';
import 'package:proj/screen/Admin/manage_admin_screen.dart';
import 'package:proj/screen/Admin/manage_device_screen.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/screen/login.dart';
import 'package:proj/widget/showTitle.dart';

import '../logoutSSO.dart';

class HomeAdminScreen extends StatefulWidget {
  final String name;
  final String email;
  const HomeAdminScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  // List<String> nameAd = ["มานี มานะ", "กล้าแก้ว ชูใจ ", "โกโกวา ที่หนูอยากได้"];

  @override
  Widget build(BuildContext context) {
    double size18 = MediaQuery.of(context).size.width * 0.045;
    double size20 = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2,
        toolbarHeight: 65,
        //centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              iconSize: 24,
              color: kPrimaryColor,
              onPressed: () {
                print(widget.name);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            name: widget.name,
                            email: widget.email,
                            admin: true,
                          )),
                );
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 24,
              color: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutSSOScreen()),
                );
              })
        ],
        title: showTitle(size20),
        // remove back button
        automaticallyImplyLeading: false,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 50),
            children: <Widget>[
              Card(
                color: Colors.white,
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.person_add,
                        color: kPrimaryColor,
                      ),
                      title: Text("จัดการผู้ดูแล",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size18,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageAdminScreen(
                                      name: widget.name,
                                      email: widget.email,
                                    )));
                      },
                    )
                  ],
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: kPrimaryColor,
                      ),
                      title: Text("จัดการอุปกรณ์",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size18,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageDeviceScreen(
                              name: widget.name,
                              email: widget.email,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
