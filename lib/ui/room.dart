import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:techvillaautomation/controllers/qr_controller.dart';
import 'package:techvillaautomation/model/RoomModel.dart';

import '../theme.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('S401');

  @override
  void initState() {
    super.initState();
  }

  final qrController = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title:
            Text(roomData[qrController.indexNum.value]['roomName'].toString()),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  qrController.scanQR();
                },
                child: Icon(Icons.scanner),
              )),
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder(
            future: reference.get(),
            builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                print('kool');
                print(snapshot.data!.value);
               // Model mm - Model.formjson(snapshot.data!.value);
                return Container(
                child :Text(snapshot.data!.value['R7'].toString()) ,
                );
              }
              return Container();
            },
          )),
    );
  }
}
