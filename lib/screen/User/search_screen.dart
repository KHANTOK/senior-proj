import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/components/Loading.dart';
import 'package:proj/model/device_data.dart';
import 'package:proj/screen/User/device_detail_screen.dart';
import 'package:proj/screen/User/profile_screen.dart';
import 'package:proj/screen/login.dart';
import 'package:proj/widget/showTitle.dart';

import '../../model/DeviceModel.dart';
import '../../services/DeviceService.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  List<Map<String, dynamic>> _allDevice = devices;

  // This list holds the data for the list view
  // (ลิสต์เก็บข้อมูลค้นหา)
  List<String> _foundDeviceName = [];
  List<int> _foundDeviceTotalAvailable = [];
  List<String> _foundDeviceImg = [];
  List<int> _foundDeviceDuration = [];
  List<DeviceModel> device = [];
  List<String> imagePath = [
    'assets/images/applePen.png',
    'assets/images/trueChrome.png',
    'assets/images/v14.jpg'
  ];
  bool isLoading = false;
  bool isSearching = false;
  bool isFound = false;

  @override
  initState() {
    // at the beginning, all users are shown
    // (ในตอนเริ่มต้นจะแสดงผู้ใช้ทั้งหมด)
    getDevice();
    super.initState();
  }

  // call api
  void getDevice() async {
    setState(() {
      isLoading = true;
    });
    var response = await DeviceService();
    device = response;
    setState(() {
      isLoading = false;
    });
  }

  // This function is called whenever the text field changes
  // (ฟังก์ชันนี้ถูกเรียกเมื่อใดก็ตามที่ช่องข้อความเปลี่ยนแปลง)
  void _runFilter(String enteredKeyword) {
    setState(() {
      isFound = false;
      _foundDeviceName.clear();
      _foundDeviceTotalAvailable.clear();
      _foundDeviceImg.clear();
      _foundDeviceDuration.clear();
    });
    for (var i = 0; i < device.length; i++) {
      if (device[i].id.toLowerCase().contains(enteredKeyword.toLowerCase())) {
        setState(() {
          isFound = true;
        });
        _foundDeviceName.add(device[i].id);
        _foundDeviceTotalAvailable.add(device[i].totalAvailable);
        _foundDeviceImg.add(imagePath[i]);
        _foundDeviceDuration.add(5);
      }
    }
    // we use the toLowerCase() method to make it case-insensitive
    // (ใช้วิธี toLowerCase() เพื่อให้ไม่คำนึงถึงขนาดตัวพิมพ์)
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingCircle()
        : Scaffold(
            appBar: AppBar(
              titleSpacing: 2,
              toolbarHeight: 65,
              //centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: showTitle(),
              actions: [
                IconButton(
                    icon: const Icon(Icons.account_circle),
                    iconSize: 24,
                    color: kPrimaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    }),
                IconButton(
                    icon: const Icon(Icons.logout),
                    iconSize: 24,
                    color: kPrimaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    })
              ],
              // remove back button
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
                    child: TextField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            isSearching = false;
                          });
                        } else {
                          _runFilter(value);
                          setState(() {
                            isSearching = true;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ค้นหา',
                          hintText: 'หอสมุดกลาง',
                          suffixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.all(15)),
                    ),
                  ),
                  Column(
                    children: isSearching
                        ? isFound
                            ? [
                                for (var i = 0;
                                    i < _foundDeviceName.length;
                                    i++)
                                  cardItem(
                                      _foundDeviceImg[i],
                                      _foundDeviceName[i],
                                      _foundDeviceTotalAvailable[i].toString(),_foundDeviceDuration[i]),
                              ]
                            : [
                                const Text(
                                  'No results found',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black),
                                )
                              ]
                        : [
                            for (var i = 0; i < device.length; i++)
                              cardItem(imagePath[i], device[i].id,
                                  device[i].totalAvailable.toString(), 5),
                          ],
                  ),
                ],
              ),
            ));
  }

  Widget cardItem(String img, String name, String totalAvailable, int duration) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeviceDetailScreen(id: name)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: AvatarView(
                radius: 40,
                borderColor: Colors.white,
                avatarType: AvatarType.RECTANGLE,
                backgroundColor: Colors.red,
                imagePath: img,
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
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                  'ระยะการยืม : ',
                  style: const TextStyle(color: timeColor, fontSize: 14),
                ),
                Text(
                  'คงเหลือทั้งหมด : ' + totalAvailable.toString(),
                  style: const TextStyle(
                      color: remainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
