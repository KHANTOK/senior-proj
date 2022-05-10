import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj/screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KKUL',
      theme: ThemeData(
        // This is the theme of your application.
        primaryTextTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).primaryTextTheme
        ),
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme
              ),
        scaffoldBackgroundColor: Colors.white),
      home: const LoginScreen(),
    );
  }
}

