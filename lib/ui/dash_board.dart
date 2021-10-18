import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';
import 'package:techvillaautomation/controllers/qr_controller.dart';
import 'package:techvillaautomation/model/RoomModel.dart';
import 'package:techvillaautomation/theme.dart';
import 'package:techvillaautomation/ui/drawer/contact_us.dart';
import 'package:techvillaautomation/ui/drawer/profile.dart';
import 'package:techvillaautomation/ui/drawer/stats.dart';
import 'package:techvillaautomation/ui/room.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final controller = Get.put(FirebaseController());
  final qrController = Get.put(QrController());

  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('data').child('S401');

  final dbRef = FirebaseDatabase.instance.reference().child('users');
  final ref = FirebaseDatabase.instance;
  String userId = "";
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<dynamic> listShow = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  loadUser() {
    final User? user = _auth.currentUser;
    userId = user!.uid.toString();
  }

  final dropdownvalue = 'Room'.obs;

  var items = [
    'Room',
    'Main Gate',
    'Water Motor',
    'Tv Lounge',
  ];
  final TextEditingController roomNameText = TextEditingController();

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
        title: Text("DashBoard"),
      ),
      drawer: new Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(),
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

            /// profile
            InkWell(
              onTap: () {
                Get.to(ProfileScreen());
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
            ),

            /// Stats
            InkWell(
              onTap: () {
                Get.to(Stats());
              },
              child: ListTile(
                leading: Icon(Icons.stacked_bar_chart),
                title: Text("Statistics"),
              ),
            ),

            /// About US
            InkWell(
              onTap: () {
                Get.to(Contact());
              },
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("About Us"),
              ),
            ),

            /// Contact US
            InkWell(
              onTap: () {
                Get.to(
                  Contact(),
                );
              },
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text("Contact Us"),
              ),
            ),

            /// logout
            GestureDetector(
              onTap: () {
                controller.signOut();
                controller.google_signOut();
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black12,
                child: Column(
                  children: [
                    ///heading
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Center(
                                    child: Text(
                                      "Home Automation",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0, top: 5, bottom: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          print("after");
                                          print("before");
                                          Get.defaultDialog(
                                            title: "Add Rooms",
                                            middleText: "Hello world!",
                                            //  backgroundColor: Colors.green,
                                            // titleStyle: TextStyle(color: Colors.white),
                                            //middleTextStyle: TextStyle(color: Colors.white),
                                            textConfirm: "Add",
                                            textCancel: "Cancel",
                                            onConfirm: () {
                                              //roomData.add(dropdownvalue.value);
                                              controller.createRoom(
                                                  roomNameText.text,
                                                  dropdownvalue.value,
                                                  dropdownvalue.value);
                                              roomData.add({
                                                "roomType": dropdownvalue.value,
                                                "roomName": roomNameText.text,
                                                "icon": dropdownvalue.value,
                                              });
                                              roomNameText.clear();
                                              Get.back();
                                            },
                                            cancelTextColor: Colors.black,
                                            confirmTextColor: Colors.black,
                                            buttonColor: Color(0xFF029b93),
                                            barrierDismissible: false,
                                            content: Column(
                                              children: [
                                                Obx(
                                                  () {
                                                    return DropdownButton(
                                                      value:
                                                          dropdownvalue.value,
                                                      icon: Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        dropdownvalue.value =
                                                            newValue.toString();
                                                      },
                                                    );
                                                  },
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Enter Name',
                                                      hintText: 'Enter Name'),
                                                  controller: roomNameText,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.black12,
                                            width: 60,
                                            height: 60,
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///body
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                          child: Container(
                            width: double.infinity,
                            child: ListView(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      //margin: EdgeInsets.only(top: 20,bottom: 10),
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      // color: Colors.deepPurple,
                                      height: 35.h,
                                      // / color: Colors.yellow,
                                      child: StreamBuilder(
                                        stream: dbRef
                                            .child(userId)
                                            .child('Rooms')
                                            .onValue,
                                        builder: (context,
                                            AsyncSnapshot<Event> snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text('Loading');
                                          } else if (!snapshot
                                              .data!.snapshot.exists) {
                                            return Column(
                                              children: [
                                                Obx(() {
                                                  return Column(
                                                    children: [
                                                      roomData.isEmpty
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 100),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.defaultDialog(
                                                                    title:
                                                                        "Add Rooms",
                                                                    middleText:
                                                                        "",
                                                                    //  backgroundColor: Colors.green,
                                                                    // titleStyle: TextStyle(color: Colors.white),
                                                                    //middleTextStyle: TextStyle(color: Colors.white),
                                                                    textConfirm:
                                                                        "Add",
                                                                    textCancel:
                                                                        "Cancel",
                                                                    onConfirm:
                                                                        () {
                                                                      //roomData.add(dropdownvalue.value);
                                                                      controller.createRoom(
                                                                          roomNameText
                                                                              .text,
                                                                          dropdownvalue
                                                                              .value,
                                                                          dropdownvalue
                                                                              .value);
                                                                      roomData
                                                                          .add({
                                                                        "roomType":
                                                                            dropdownvalue.value,
                                                                        "roomName":
                                                                            roomNameText.text,
                                                                        "icon":
                                                                            dropdownvalue.value,
                                                                      });
                                                                      roomNameText
                                                                          .clear();
                                                                      Get.back();
                                                                    },
                                                                    cancelTextColor:
                                                                        Colors
                                                                            .black,
                                                                    confirmTextColor:
                                                                        Colors
                                                                            .black,
                                                                    buttonColor:
                                                                        Color(
                                                                            0xFF029b93),
                                                                    barrierDismissible:
                                                                        false,
                                                                    content:
                                                                        Column(
                                                                      children: [
                                                                        Obx(
                                                                          () {
                                                                            return DropdownButton(
                                                                              value: dropdownvalue.value,
                                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                                              items: items.map((String items) {
                                                                                return DropdownMenuItem(value: items, child: Text(items));
                                                                              }).toList(),
                                                                              onChanged: (newValue) {
                                                                                dropdownvalue.value = newValue.toString();
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                        TextField(
                                                                          decoration: InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              labelText: 'Enter Name',
                                                                              hintText: 'Enter Name'),
                                                                          controller:
                                                                              roomNameText,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child: ClipOval(
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .black12,
                                                                    width: 60,
                                                                    height: 60,
                                                                    child: Icon(
                                                                        Icons
                                                                            .add),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                      listShow.isEmpty
                                                          ? Text(
                                                              "No Rooms Click + to add")
                                                          : Container(),
                                                    ],
                                                  );
                                                }),
                                              ],
                                            );
                                          } else {
                                            Map<dynamic, dynamic> map =
                                                snapshot.data!.snapshot.value;

                                            List<dynamic> list = [];

                                            list.clear();
                                            list = map.values.toList();

                                            print(list);
                                            print("now");

                                            return GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3),
                                              itemCount: list.length,
                                              padding: EdgeInsets.all(2.0),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    RoomScreen(
                                                                      index:
                                                                          index,
                                                                      name: list[
                                                                              index]
                                                                          [
                                                                          'Room Name'],
                                                                      roomId: list[
                                                                              index]
                                                                          [
                                                                          'roomId'],
                                                                    )));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: CustomTheme
                                                              .loginGradientEnd,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        height: 10.h,
                                                        width: 10.h,
                                                        child: Center(
                                                          child: Image.asset(
                                                            "assets/" +
                                                                list[index][
                                                                    'Room Type'] +
                                                                ".png",
                                                            height: 5.h,
                                                            width: 5.h,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            list[index]
                                                                ['Room Name'],
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black12,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            //  controller.readRoom();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2,
                            child: Center(
                              child: Text(
                                "Commercial Automation",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                          child: Container(
                            width: double.infinity,
                            // child: Column(
                            //   children: [
                            //     Column(
                            //       children: [
                            //         RaisedButton(
                            //           child: Text('Create Data'),
                            //           color: Colors.redAccent,
                            //           onPressed: () {
                            //             controller.createData();
                            //           },
                            //           shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.all(
                            //                   Radius.circular(20))),
                            //         ),
                            //         RaisedButton(
                            //           child: Text('read data'),
                            //           color: Colors.redAccent,
                            //           onPressed: () {
                            //             controller.readData();
                            //           },
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //               Radius.circular(20),
                            //             ),
                            //           ),
                            //         ),
                            //         RaisedButton(
                            //           child: Text('update data'),
                            //           color: Colors.redAccent,
                            //           onPressed: () {
                            //             controller.updateData();
                            //           },
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //               Radius.circular(20),
                            //             ),
                            //           ),
                            //         ),
                            //         RaisedButton(
                            //           child: Text('delt data'),
                            //           color: Colors.redAccent,
                            //           onPressed: () {
                            //             controller.deleteData();
                            //           },
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.all(
                            //               Radius.circular(20),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Obx(() {
                            //       return Text(qrController.result.toString());
                            //     }),
                            //     MaterialButton(
                            //       onPressed: () {
                            //         qrController.scanQR();
                            //       },
                            //       child: Icon(Icons.camera_alt),
                            //     )
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
