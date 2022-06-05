import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:proj/screen/login.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LogoutSSOScreen extends StatefulWidget {
  LogoutSSOScreen({Key? key}) : super(key: key);

  @override
  State<LogoutSSOScreen> createState() => _LogoutSSOScreenState();
}

class _LogoutSSOScreenState extends State<LogoutSSOScreen> {
  late WebViewController _controller;
  final LocalStorage storage = LocalStorage('');
  String token = "";
  String url = "https://libsso2.kku.ac.th/logout.php?token=";
  @override
  void initState() {
    super.initState();
    token = storage.getItem('token');
    url = url + token;
    storage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      onPageFinished: (_) {
        print("Logout");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    );
  }
}
