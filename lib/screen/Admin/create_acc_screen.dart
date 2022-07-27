import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/manage_admin_screen.dart';
import 'package:proj/widget/button.dart';

import '../../services/AccountService.dart';

class CreateAccScreen extends StatefulWidget {
  final String name;
  final String email;
  const CreateAccScreen({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  _CreateAccScreenState createState() => _CreateAccScreenState();
}

class _CreateAccScreenState extends State<CreateAccScreen> {
  // ตัวแปรสำหรับรับค่าจาก TextField และ call api
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // ตัวแปรสำหรับ call api
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double size20 = MediaQuery.of(context).size.width * 0.05;
    double size18 = MediaQuery.of(context).size.width * 0.045;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "เพิ่มผู้ดูแล",
            style: TextStyle(color: Colors.black, fontSize: size20),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ManageAdminScreen(
                  name: widget.name,
                  email: widget.email,
                );
              }));
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ชื่อและนามสกุล',
                    labelStyle: TextStyle(color: kPrimaryColor, fontSize: size18),
                    helperText: 'ตัวอย่าง : มาณี อุดมสุข',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อและนามสกุล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'อีเมล์',
                      labelStyle:
                          TextStyle(color: kPrimaryColor, fontSize: size18),
                      helperText: 'ตัวอย่าง : manee@kku.ac.th'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกอีเมลล์';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "กรุณากรอกอีเมลให้ถูกต้อง";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: AppsButton.button(
                      label: isLoading ? "กำลังสร้างบัญชี.." : "สร้างบัญชี",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // call api create account
                          setState(() {
                            isLoading = true;
                          });
                          await CreateAccountService(
                            nameController.text,
                            emailController.text,
                          );
                          setState(() {
                            isLoading = false;
                          });
                          // after create account จะย้อนกลับไปหน้าก่อนหน้านี้
                          print(widget.name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageAdminScreen(
                                        name: widget.name,
                                        email: widget.email,
                                      )));
                        }
                      },
                      height: 48,
                      width: 300),
                ),
              ],
            ),
          ),
        ));
  }
}
