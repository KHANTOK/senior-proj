import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/widget/button.dart';

import '../../components/Loading.dart';
import '../../services/AccountService.dart';

class CreateAccScreen extends StatefulWidget {
  const CreateAccScreen({Key? key}) : super(key: key);

  @override
  _CreateAccScreenState createState() => _CreateAccScreenState();
}

class _CreateAccScreenState extends State<CreateAccScreen> {
  // ตัวแปรสำหรับรับค่าจาก TextField และ call api
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // ตัวแปรสำหรับ call api
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "จัดการผู้ดูแล",
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
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ชื่อและนามสกุล',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  helperText: 'ตัวอย่าง : มาณี อุดมสุข',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'อีเมล',
                    labelStyle: TextStyle(color: kPrimaryColor),
                    helperText: 'ตัวอย่าง : manee@kku.ac.th'),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: AppsButton.button(
                    label: isLoading ? "กำลังสร้างบัญชี.." : "สร้างบัญชี",
                    onPressed: () async {
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
                      Navigator.pop(context);
                    },
                    height: 48,
                    width: 300),
              ),
            ],
          ),
        ));
  }
}
