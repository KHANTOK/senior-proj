import 'package:flutter/material.dart';
import 'package:proj/color.dart';
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
              TextField(
                onChanged: (value) {
                  bibId = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'BIB ID',
                  labelStyle: TextStyle(color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  deviceName = value;
                },
                decoration: const InputDecoration(
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
                  for (var i = 0; i < chipList.length; i++)
                    selectedChoice(chipList[i])
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  const Text(
                    "ระยะการยืม",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: TextField(
                      onChanged: (value) {
                        duration = value;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '30',
                          hintStyle: TextStyle(fontSize: 16),
                          // change the TextField height
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text("วัน", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 50),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: AppsButton.button(
                          label: "เพิ่มอุปกรณ์",
                          onPressed: () async {
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
                            await SaveDeviceFromAPIKKUService();
                            setState(() {
                              isLoading = false;
                            });
                            duration = "";
                            accession = "";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ManageDeviceScreen(
                                        name: widget.name,
                                        email: widget.email)));
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

  Widget selectedChoice(String item) {
    return ChoiceChip(
      label: Text(item),
      labelStyle: const TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
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
          print(selectedChoiceList.toString());
        });
      },
    );
  }
}
