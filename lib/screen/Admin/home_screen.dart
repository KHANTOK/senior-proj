import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/create_acc_screen.dart';
import 'package:proj/screen/Admin/manage_device_screen.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/screen/login.dart';
import 'package:proj/widget/showTitle.dart';

class HomeAddminScreen extends StatefulWidget {
  const HomeAddminScreen({Key? key}) : super(key: key);

  @override
  _HomeAddminScreenState createState() => _HomeAddminScreenState();
}

class _HomeAddminScreenState extends State<HomeAddminScreen> {
  // List<String> nameAd = ["มานี มานะ", "กล้าแก้ว ชูใจ ", "โกโกวา ที่หนูอยากได้"];

  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 24,
              color: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              })
        ],
        title: showTitle(),
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
                      title: const Text("สร้างบัญชี",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateAccScreen()));
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
                      title: const Text("เพิ่ม / แก้ไข / ลบ อุปกรณ์",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ManageDeviceScreen()));
                      },
                    )
                  ],
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ExpansionTile(
                    title: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.perm_contact_calendar,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: 30),
                        Text("รายชื่อผู้ดูแล",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    children: [
                      // ListView.builder(
                      //     itemBuilder: (context, index) => Column(
                      //           children: [
                      //             Text("555555555",
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.bold)),
                      //           ],
                      //         ))
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('มานี มานะ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text("โกโกวา ที่หนูอยากได้",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text("แก้วกล้า ชูใจ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ]),
    );
  }
}