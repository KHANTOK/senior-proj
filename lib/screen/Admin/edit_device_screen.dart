import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/widget/button.dart';

class EditDeviceScreen extends StatefulWidget {
  const EditDeviceScreen({Key? key}) : super(key: key);

  @override
  State<EditDeviceScreen> createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  List<String> chipList = [
    "บุคลากร",
    "อาจารย์",
    "นักศึกษา",
  ];
  List<String> selectedChoiceList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "แก้ไขอุปกรณ์",
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '1',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppsButton.button(
                  label: "เรียกจาก api",
                  onPressed: () {},
                  height: 48,
                  width: 150),
                  SizedBox(width: 20),
                  AppsButton.button(
                  label: "บันทึก",
                  onPressed: () {},
                  height: 48,
                  width: 150),
                ],
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
