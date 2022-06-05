import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/home_screen.dart';
import 'package:proj/screen/User/fav_screen.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/screen/login.dart';
import 'package:proj/widget/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/AccountModel.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final bool? admin;
  const ProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    this.admin,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String _number = '082-548-4163';

  @override
  void initState() {
    print(widget.name);
    super.initState();
  }

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
                if (widget.admin != null) {
                  if (widget.admin == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                name: widget.name,
                                email: widget.email,
                                admin: true,
                              )),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              name: widget.name,
                              email: widget.email,
                            )),
                  );
                }
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 24,
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: ListTile(
                                  title: Text(
                                    'ติดต่อเจ้าหน้าที่',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  subtitle: Text(
                                    'สำนักหอสมุด มหาวิทยาลัยขอนแก่น 123 ถนนมิตรภาพ ต.ในเมือง อ.เมือง จ.ขอนแก่น 40002',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),

                                content: ListTile(
                                  title: Text('Max : 082-548-4163'),
                                  trailing: TextButton(
                                    child: Text('call'),
                                    onPressed: () async {
                                      final _call = 'tel:$_number';
                                      final _text = 'sms:$_number';
                                      if (await canLaunch(_call)) {
                                        await launch(_call);
                                      }
                                    },
                                  ),
                                ),

                                // Text('Max : 082-548-4163'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: Text('OK'))
                                ],
                              ));
                    },
                    height: 34,
                    width: 150)
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 50),
              children: [
                Visibility(
                  visible: widget.admin != null ? widget.admin! : false,
                  child: Card(
                    color: Colors.white,
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(
                            Icons.home,
                            color: accentColor,
                          ),
                          title: const Text("หน้าหลักแอดมิน",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeAdminScreen(
                                          name: widget.name,
                                          email: widget.email,
                                        )));
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.admin == null ? true : false,
                  child: Card(
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
