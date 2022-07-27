import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/components/Loading.dart';
import 'package:proj/widget/button.dart';

import '../../services/DeviceService.dart';
import '../../services/ManageDeviceService.dart';
import 'manage_device_screen.dart';

class AddDeviceScreen extends StatefulWidget {
  final String name;
  final String email;
  const AddDeviceScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> chipList = [
    "บุคลากร",
    "อาจารย์",
    "นักศึกษา",
  ];
  List<String> selectedChoiceList = [];
  String bibId = "";
  String deviceName = "";
  String accession = "";
  String duration = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double size18 = MediaQuery.of(context).size.width * 0.045;
    double size20 = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "เพิ่มอุปกรณ์",
          style: TextStyle(color: Colors.black, fontSize: size20),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ManageDeviceScreen(
                name: widget.name,
                email: widget.email,
              );
            }));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (value) {
                    bibId = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'BIB ID',
                    labelStyle:
                        TextStyle(color: kPrimaryColor, fontSize: size18),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอก BIB ID';
                    }
                    if (value.length < 9 || value.length > 9) {
                      return 'กรุณากรอก BIB ID ให้ถูกต้อง';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    deviceName = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ชื่ออุปกรณ์',
                    labelStyle:
                        TextStyle(color: kPrimaryColor, fontSize: size18),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่ออุปกรณ์';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "ผู้มีสิทธิ์ยืม",
                  style:
                      TextStyle(fontSize: size18, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 15.0,
                  runSpacing: 5.0,
                  children: <Widget>[
                    for (var i = 0; i < chipList.length; i++)
                      selectedChoice(chipList[i])
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text(
                      "ระยะการยืม",
                      style: TextStyle(
                          fontSize: size18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: TextFormField(
                        onChanged: (value) {
                          duration = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '1',
                            hintStyle: TextStyle(fontSize: size18),
                            // change the TextField height
                            contentPadding: EdgeInsets.all(10)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกระยะการยืม';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text("วัน", style: TextStyle(fontSize: size18)),
                  ],
                ),
                const SizedBox(height: 50),
                isLoading
                    ? LoadingCircle()
                    : Center(
                        child: AppsButton.button(
                            label: "เพิ่มอุปกรณ์",
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                duration += " วัน";
                                for (var i = 0;
                                    i < selectedChoiceList.length;
                                    i++) {
                                  accession += selectedChoiceList[i] + " ";
                                }
                                setState(() {
                                  isLoading = true;
                                });
                                await ImportOtherDeviceService(
                                    bibId, deviceName, accession, duration);
                                await SaveDeviceFromAPIKKUService(
                                    bibId, deviceName);
                                setState(() {
                                  isLoading = false;
                                });
                                duration = "";
                                accession = "";
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManageDeviceScreen(
                                                name: widget.name,
                                                email: widget.email)));
                              }
                            },
                            height: 48,
                            width: 300),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectedChoice(String item) {
    double size1 = MediaQuery.of(context).size.width * 0.045;

    return ChoiceChip(
      label: Text(item),
      labelStyle: TextStyle(
          color: Colors.white, fontSize: size1, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.grey,
      // Color(0xffededed),
      selectedColor: kPrimaryColor,
      // Color(0xffffc107),
      selected: selectedChoiceList.contains(item),
      onSelected: (selected) {
        setState(() {
          if (selectedChoiceList.contains(item)) {
            selectedChoiceList.remove(item);
          } else {
            selectedChoiceList.add(item);
          }
        });
      },
    );
  }
}
