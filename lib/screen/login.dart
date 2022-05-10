import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:proj/model/profile.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/widget/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

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
                    //Text("ชื่อผู้ใช้", style: TextStyle(fontSize: 20)),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "ชื่อผู้ใช้"),
                      validator:
                          RequiredValidator(errorText: "กรุณาป้อนชื่อผู้ใช้"),
                      // //EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")

                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) {
                        profile.email = email!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                    TextFormField(
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "รหัสผ่าน",
                        ),
                        obscureText: true,
                        validator:
                            RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                        onSaved: (password) {
                          profile.password = password!;
                        }
                        // validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                        //
                        ),
                    const SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                      child: AppsButton.button(
                          label: "เข้าสู่ระบบด้วย GMAIL",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen()),
                            );
                          },
                          height: 48,
                          width: 300),
                    )
                    // SizedBox(
                    //   height: 50,
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //       child: Text("เข้าสู่ระบบด้วย GMAIL",
                    //           style: TextStyle(fontSize: 18)),
                    //       onPressed: () {
                    //         // if (formKey.currentState!.validate()) {
                    //         //   formKey.currentState!.save();
                    //         //   print(
                    //         //       "email = ${profile.email} password = ${profile.password}");
                    //         //   formKey.currentState!.reset();
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const FirstScreen()),
                    //         );
                    //         // }
                    //       }),
                    // )
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