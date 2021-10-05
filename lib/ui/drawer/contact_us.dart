import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';
import '../login.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Get.back();
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  CustomTheme.loginGradientEnd,
                  CustomTheme.loginGradientStart
                ],
                begin: FractionalOffset(0.2, 0.2),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.1, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text("Contact Us"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dean Trade Center Peshawar"),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("+92 316 1702750"),
          ),
          GestureDetector(
            onTap: () {
              _launchUrl("www.google.com");
              print("Pressed");
            },
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text("techvillaautomation@yahoo.com"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.web),
            title: Text("www.techvillaautomation.com"),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String urlString) async {
  if (await canLaunch(urlString)) {
    await launch(
      urlString,
      forceWebView: true,
    );
  } else {
    print("Can\'t Launch Url");
  }
}
