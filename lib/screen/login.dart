import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/widget/button.dart';

import '../components/Loading.dart';
import '../services/AccountService.dart';
import 'Admin/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/LogoKKU.png',
                          height: 100,
                          width: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "KKUL",
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "มหาวิทยาลัยขอนแก่น",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                            Text(
                              "Khon Kaen University Library",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "ชื่อผู้ใช้"),
                      validator:
                          RequiredValidator(errorText: "กรุณากรอกอีเมล์"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "รหัสผ่าน",
                      ),
                      obscureText: true,
                      validator:
                          RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    isLoading
                        ? LoadingCircle()
                        : SizedBox(
                            child: AppsButton.button(
                                label: "เข้าสู่ระบบ",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var login = await LoginService(
                                        email.text, password.text);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (login.status == "user") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchScreen(
                                            name: login.name,
                                            email: login.email,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeAdminScreen(
                                            name: login.name,
                                            email: login.email,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                height: 48,
                                width: 300),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
