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
  late Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('S401');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('S401');
  }

  Widget _buildDeviceItem({required Map device}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 130,
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    device['R1'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ]));
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
        child: Column(
          children: [
            Container(
              height: 300,
              width: 400,
              child: FirebaseAnimatedList(
                query: _ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  print(' ${snapshot.value}');
                  Map<dynamic, dynamic> device = snapshot.value;
                  // contact['key'] = snapshot.key;
                  return _buildDeviceItem(device: device);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 21),
              // color: Colors.deepPurple,
              height: 200,
              child: Obx(() {
                return ListView.builder(
                    padding: EdgeInsets.only(left: 25, right: 6),
                    itemCount: roomData.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.back();
                          print("back");
                        },
                        child: Center(
                          child: Container(
                            color: Colors.grey,
                            margin: EdgeInsets.only(right: 19),
                            height: 200,
                            width: 200,
                            child: Column(
                              children: [
                                Text(roomData[index]['roomType'].toString()),
                                Text(roomData[index]['roomName'].toString()),
                                Image.asset(
                                  "assets/" +
                                      roomData[index]['icon'].toString(),
                                ),
                                Image.asset(
                                  "assets/Main Gate.png",
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
