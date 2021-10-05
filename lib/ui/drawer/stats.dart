import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';
import '../login.dart';

class Stats extends StatelessWidget {
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
        title: Text("Statistics"),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Text("10", style: Get.textTheme.headline3),
                        Text(
                          "Number of room",
                          style: Get.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Text("10", style: Get.textTheme.headline3),
                        Text(
                          "Number of Devices",
                          style: Get.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Text("250", style: Get.textTheme.headline3),
                        Text(
                          "Total voltage Consumed",
                          style: Get.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
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
