import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/model/device_data.dart';
import 'package:proj/screen/Admin/add_device_screen.dart';

class ManageDeviceScreen extends StatefulWidget {
  const ManageDeviceScreen({Key? key}) : super(key: key);

  @override
  _ManageDeviceScreenState createState() => _ManageDeviceScreenState();
}

class _ManageDeviceScreenState extends State<ManageDeviceScreen> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allDevice = devices;
  final List<bool> _switchValues = List.generate(devices.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "จัดการอุปกรณ์",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _allDevice.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Container(
                        height: 200,
                        child: Card(
                          color: Colors.white,
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: AvatarView(
                                  radius: 40,
                                  borderColor: Colors.white,
                                  avatarType: AvatarType.RECTANGLE,
                                  backgroundColor: Colors.red,
                                  imagePath: _allDevice[index]['img'],
                                  placeHolder: Container(
                                    child: const Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                  ),
                                  errorWidget: Container(
                                    child: const Icon(
                                      Icons.error,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                title: Text(_allDevice[index]['bib'],
                                    style: const TextStyle(
                                        color: accentColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'ผู้สิทธิ์ยืม : ${_allDevice[index]["borrower"].toString()}',
                                      style: const TextStyle(
                                          color: timeColor, fontSize: 14),
                                    ),
                                    Text(
                                      'ระยะการยืม : ${_allDevice[index]["time"].toString()}',
                                      style: const TextStyle(
                                          color: timeColor, fontSize: 14),
                                    ),
                                  ],
                                ),
                                // trailing: Icon(Icons.close)
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Transform.scale(
                                    scale: 0.7,
                                    child: CupertinoSwitch(
                                      value: _switchValues[index],
                                      onChanged: (bool value) {
                                        setState(() {
                                          _switchValues[index] = value;
                                        });
                                      },
                                      activeColor: accentColor,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
          const SizedBox(height: 50)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddDeviceScreen()));
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
