import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/manage_device_screen.dart';
import 'package:proj/widget/button.dart';
import 'package:proj/widget/choiceChip.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  List<String> chipList = [
    "บุคลากร",
    "อาจารย์",
    "นักศึกษา",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "เพิ่มอุปกรณ์",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 138,
                  width: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        color: Colors.grey,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BIB ID',
                  labelStyle: TextStyle(color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ชื่ออุปกรณ์',
                  labelStyle: TextStyle(color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "ผู้มีสิทธิ์ยืม",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 15.0,
                runSpacing: 5.0,
                children: <Widget>[
                  // filterChipWidget(chipName: 'บุคลากร'),
                  // filterChipWidget(chipName: 'อาจารย์'),
                  // filterChipWidget(chipName: 'นักศึกษา'),
                  choiceChipWidget(chipList),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const <Widget>[
                  Text(
                    "ระยะการยืม",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '30',
                          hintStyle: TextStyle(fontSize: 16),
                          // change the TextField height
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(width: 15),
                  // DropdownButtonFormField(items: items, onChanged: onChanged)
                  // Flexible(
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         hintText: 'วัน',
                  //         hintStyle: TextStyle(fontSize: 16),
                  //         // change the TextField height
                  //         contentPadding: EdgeInsets.all(10)),
                  //   ),
                  // )
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'วัน',
                          hintStyle: TextStyle(fontSize: 16),
                          // change the TextField height
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: AppsButton.button(
                    label: "เพิ่มอุปกรณ์",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ManageDeviceScreen()));
                    },
                    height: 48,
                    width: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}