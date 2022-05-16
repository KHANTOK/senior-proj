import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/home_screen.dart';
import 'package:proj/screen/User/fav_screen.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/widget/button.dart';

import '../../model/AccountModel.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  const ProfileScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pfColor, elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              iconSize: 24,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 24,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeAdminScreen(
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              })
        ], // remove back button
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
            height: 133,
            width: double.infinity,
            color: pfColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "สวัสดี " + widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                AppsButton.button(
                    label: 'ติดต่อเจ้าหน้าที่',
                    onPressed: () {},
                    height: 34,
                    width: 150)
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 50),
              children: [
                Card(
                  color: Colors.white,
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          Icons.favorite,
                          color: accentColor,
                        ),
                        title: const Text("รายการโปรด",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavScreen(
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ExpansionTile(
                          title: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.report_outlined,
                                color: accentColor,
                              ),
                              SizedBox(width: 30),
                              Text("เกี่ยวกับแอปพลิเคชัน",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          children: const <Widget>[
                            ListTile(
                              // leading: Icon(
                              //   Icons.report_outlined,
                              //   color: accentColor,
                              // ),
                              title: Text("แอปพลิเคชันตรวจสอบอุปกรณ์เพื่อขอยืม",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                    "โมบายแอปพลิเคชันสำหรับการตรวจสอบอุปกรณ์ให้ยืมในหอสมุด มหาวิทยาลัยขอนแก่น เพื่อให้นักศึกษาสามารถเข้าถึงทรัพยากรสารสนเทศผ่านมือถือหรือแท็บเล็ต อีกทั้งยังสามารถตรวจสอบจำนวนอุปกรณ์คงเหลือและได้รับการแจ้งเตือนเมื่อมีอุปกรณ์ที่พร้อมให้ยืม",
                                    maxLines: 7,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                            ListTile(
                              // leading: Icon(
                              //   Icons.report_outlined,
                              //   color: accentColor,
                              // ),
                              title: Text("ใบอนุญาต",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                    "สัญญาอนุญาตสำนักหอสมุดมหาวิทยาลัยขอนแก่น",
                                    // maxLines: 7,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                            ListTile(
                              // leading: Icon(
                              //   Icons.report_outlined,
                              //   color: accentColor,
                              // ),
                              title: Text("เวอร์ชัน",
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text("1.0",
                                    // maxLines: 7,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                          ])
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
