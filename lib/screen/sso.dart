import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'User/search_screen.dart';

class SSOScreen extends StatefulWidget {
  SSOScreen({Key? key}) : super(key: key);

  @override
  State<SSOScreen> createState() => _SSOScreenState();
}

class _SSOScreenState extends State<SSOScreen> {
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://sso.kku.ac.th/module.php/kkuauth/authpage.php?ReturnTo=https%3A%2F%2Fsso.kku.ac.th%2Fmodule.php%2Fkkuauth%2Fresume.php%3FState%3D_8d13b31e9d11cc49a4c2149be3a72f44aa86264974%253Ahttps%253A%252F%252Fsso.kku.ac.th%252Fsaml2%252Fidp%252FSSOService.php%253Fspentityid%253Dhttps%25253A%25252F%25252Flibsso2.kku.ac.th%25252Fsaml%25252Fwww%25252Fmodule.php%25252Fsaml%25252Fsp%25252Fmetadata.php%25252Fdefault-sp%2526cookieTime%253D1653913331%2526RelayState%253Dhttps%25253A%25252F%25252Flibsso2.kku.ac.th%25252Flogin.php%25253Ftoken%25253DygdH7i4e6cbu87tu43e6e4857jHG8dfghh9045FGjfu75robhteFGH94v7fhHDL0afgjKIHGFF',
      onWebViewCreated: (controller) {
        _controller = controller;
      },
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      onPageFinished: (_) {
        _controller
            .runJavascriptReturningResult("document.documentElement.innerHTML")
            .then((value) {
          var response = jsonDecode(value);
          var data =
              response.toString().substring(19, response.toString().length - 7);
          Map<String, dynamic> map = jsonDecode(data);

          if (map['message'] == "success") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  email: map['email'],
                  name: map['firstname'] + " " + map['lastname'],
                ),
              ),
            );
          } else {
            Navigator.pop(context);
          }
        });
      },
    );
  }
}
