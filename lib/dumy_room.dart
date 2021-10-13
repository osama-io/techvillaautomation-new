import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techvillaautomation/controllers/qr_controller.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class DumyRoom extends StatefulWidget {

  String name ;
   DumyRoom({required this.name});

  @override
  _DumyRoomState createState() => _DumyRoomState();
}

class _DumyRoomState extends State<DumyRoom> {

  String code = "" ;
  late DatabaseReference reference =  FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  final qrController = Get.put(QrController());

  final result = "heloooo".obs;
  var indexNum = 1.obs;

  Future scanQR() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? cameraScanResult = await scanner.scan();
      result.value = cameraScanResult!;
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        String? cameraScanResult = await scanner.scan();
        result.value = cameraScanResult!;
      }
    }
    setState(() {
      code = result.value.toString() ;
    });
    print("myvalue"+result.value);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  scanQR() ;
                 // qrController.scanQR();
                },
                child: Icon(Icons.scanner),
              )),
        ],
      ),
      body: Column(
        children: [
          if(code != "")
          Expanded(
            child: FirebaseAnimatedList(
              query: reference.child(code),
              itemBuilder: (
                  BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                var data = snapshot.value;
                print(snapshot.value);
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(radius: 15 , backgroundColor: Colors.blue,),
                      title: Text(snapshot.value.toString()),

                    )

                  ],
                );
              },

            ),
          )
        ],
      ),
    );
  }
}
