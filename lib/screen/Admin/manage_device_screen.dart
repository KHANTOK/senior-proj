import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/components/Loading.dart';
import 'package:proj/screen/Admin/add_device_screen.dart';
import 'package:proj/screen/Admin/edit_device_screen.dart';

import '../../model/ManageDeviceModel.dart';
import '../../services/ManageDeviceService.dart';
import 'home_screen.dart';

class ManageDeviceScreen extends StatefulWidget {
  final String name;
  final String email;
  const ManageDeviceScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _ManageDeviceScreenState createState() => _ManageDeviceScreenState();
}

class _ManageDeviceScreenState extends State<ManageDeviceScreen> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  // final List<bool> _switchValues = [false, true];
  List<ManageDeviceModel> devices = [];
  bool isLoading = false;
  List<bool> switchValue = [];

  @override
  void initState() {
    getDeviceAll();
    print(widget.name);
    super.initState();
  }

  void reFresh() {
    getDeviceAll();
  }

  void getDeviceAll() async {
    setState(() {
      isLoading = true;
    });
    var response = await DeviceAllService();
    setState(() {
      devices = response;
      for (var i = 0; i < devices.length; i++) {
        if (devices[i].unlock == "1") {
          switchValue.add(true);
        } else {
          switchValue.add(false);
        }
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "จัดการอุปกรณ์",
          style: TextStyle(color: Colors.black, fontSize: size),
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
      body: isLoading
          ? LoadingCircle()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(children: <Widget>[
                    for (var i = 0; i < devices.length; i++)
                      cardItem(
                          devices[i].image,
                          devices[i].bibId,
                          devices[i].deviceName,
                          devices[i].accession,
                          devices[i].duration,
                          switchValue[i],
                          i)
                  ]),
                  const SizedBox(height: 100)
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDeviceScreen(
                name: widget.name,
                email: widget.email,
              ),
            ),
          );
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cardItem(String img, String bib_id, String name, String accession,
      String duration, bool unlock, int index) {
    double sizeName = MediaQuery.of(context).size.width * 0.05;
    double sizeDuration = MediaQuery.of(context).size.width * 0.04;
    double sizeTotal = MediaQuery.of(context).size.width * 0.045;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 7),
            blurRadius: 10,
            spreadRadius: 2,
            color: Color.fromARGB(197, 199, 199, 199),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: AvatarView(
              radius: 40,
              borderColor: Colors.white,
              avatarType: AvatarType.RECTANGLE,
              backgroundColor: Colors.red,
              imagePath: img,
              placeHolder: const Icon(
                Icons.no_photography,
                size: 50,
              ),
              errorWidget: const Icon(
                Icons.no_photography,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'BIB ID : ' + bib_id,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: sizeName,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  name,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: sizeName,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  'ผู้มีสิทธิ์ยืม : ' + accession,
                  style: TextStyle(color: timeColor, fontSize: sizeDuration),
                ),
              ),
              Container(
                child: Text(
                  'ระยะการยืม : ' + duration,
                  style: TextStyle(color: timeColor, fontSize: sizeDuration),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.53,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          print(img);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDeviceScreen(
                                        name: widget.name,
                                        email: widget.email,
                                        img: img,
                                        bib_id: bib_id,
                                        device_name: name,
                                        accession: accession,
                                        duration: duration,
                                      )));
                        },
                        child: Text('แก้ไข',
                            style: TextStyle(fontSize: sizeDuration))),
                    Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: switchValue[index],
                        onChanged: (bool value) async {
                          setState(() {
                            switchValue[index] = value;
                          });
                          if (switchValue[index]) {
                            await updateUnlockService(name, "1");
                          } else {
                            await updateUnlockService(name, "0");
                          }
                        },
                        activeColor: accentColor,
                      ),
                    ),
                    IconButton(
                        onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('การแจ้งเตือน'),
                                content:
                                    Text('คุณต้องการลบ ' + name + ' หรือไม่'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'ยกเลิก'),
                                    child: const Text('ยกเลิก'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await DeleteDeviceService(bib_id);
                                      reFresh();
                                      Navigator.pop(context, 'ลบ');
                                    },
                                    child: const Text('ยืนยัน'),
                                  ),
                                ],
                              ),
                            ),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
