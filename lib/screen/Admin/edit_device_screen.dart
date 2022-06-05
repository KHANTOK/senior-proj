import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/components/Loading.dart';
import 'package:proj/model/EditDeviceModel.dart';
import 'package:proj/widget/button.dart';

import '../../services/DeviceService.dart';
import 'manage_device_screen.dart';

class EditDeviceScreen extends StatefulWidget {
  final String name;
  final String email;
  final String img;
  final String bib_id;
  final String device_name;
  final String accession;
  final String duration;
  const EditDeviceScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.img,
    required this.bib_id,
    required this.device_name,
    required this.accession,
    required this.duration,
  }) : super(key: key);

  @override
  State<EditDeviceScreen> createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  EditDeviceModel edit_device = EditDeviceModel(bibId: "", deviceName: "");
  String bib_id = "";
  String name = "";
  String accession = "";
  String duration = "";
  List<String> chipList = [
    "บุคลากร",
    "อาจารย์",
    "นักศึกษา",
  ];
  List<String> selectedChoiceList = [];
  bool isLoading = false;
  bool fromApi = false;
  @override
  void initState() {
    reFresh();
    super.initState();
  }

  void reFresh() {
    name = widget.device_name;
    selectedChoiceList = widget.accession.split(' ');
    duration = widget.duration.substring(0, widget.duration.length - 4);
  }

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
      body: isLoading
          ? LoadingCircle()
          : SingleChildScrollView(
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
                            Image(
                                image: NetworkImage(widget.img),
                                height: 250,
                                width: 250,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.no_photography,
                                      size: 100, color: Colors.grey);
                                }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: TextEditingController(text: widget.bib_id),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'BIB ID',
                        labelStyle: TextStyle(color: kPrimaryColor),
                      ),
                      onChanged: (value) {
                        setState(() {
                          bib_id = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: TextEditingController(
                          text: fromApi ? name : widget.device_name),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ชื่ออุปกรณ์',
                        labelStyle: TextStyle(color: kPrimaryColor),
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "ผู้มีสิทธิ์ยืม",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '1',
                                hintStyle: TextStyle(fontSize: 16),
                                // change the TextField height
                                contentPadding: EdgeInsets.all(10)),
                            initialValue: duration,
                            onChanged: (value) {
                              setState(() {
                                duration = value;
                              });
                            },
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
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var response =
                                  await EditDeviceCallAPIService(widget.bib_id);
                              setState(() {
                                edit_device = response;
                                setState(() {
                                  name = edit_device.deviceName;
                                });
                                fromApi = true;
                                isLoading = false;
                              });
                            },
                            height: 48,
                            width: 150),
                        const SizedBox(width: 20),
                        AppsButton.button(
                            label: "บันทึก",
                            onPressed: () {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('การแจ้งเตือน'),
                                        content: const Text(
                                            'คุณต้องการบันทึกหรือไม่'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'ยกเลิก'),
                                            child: const Text('ยกเลิก'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              duration += " วัน";
                                              for (var i = 0;
                                                  i < selectedChoiceList.length;
                                                  i++) {
                                                accession +=
                                                    selectedChoiceList[i] + " ";
                                              }
                                              var response =
                                                  await updateDeviceService(
                                                      widget.bib_id,
                                                      name,
                                                      accession,
                                                      duration);
                                              if (response == "success") {
                                                accession = '';
                                                duration = duration.substring(
                                                    0, duration.length - 4);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ManageDeviceScreen(
                                                              name: widget.name,
                                                              email:
                                                                  widget.email,
                                                            )));
                                              }
                                            },
                                            child: const Text('ยืนยัน'),
                                          ),
                                        ],
                                      ));
                            },
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
        });
      },
    );
  }
}
