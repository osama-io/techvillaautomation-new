import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';
import 'package:techvillaautomation/controllers/qr_controller.dart';
import 'package:techvillaautomation/dumy_screen.dart';
import 'package:techvillaautomation/model/RoomModel.dart';
import 'package:techvillaautomation/ui/drawer/contact_us.dart';
import 'package:techvillaautomation/ui/drawer/stats.dart';
import 'package:techvillaautomation/ui/room.dart';
import '../theme.dart';

import 'drawer/profile.dart';

class HomeScreen extends GetWidget<FirebaseController> {
  final qrController = Get.put(QrController());

  FirebaseController cont = FirebaseController();
  List lists = [];
  final dbRef = FirebaseDatabase.instance.reference().child('users');

  bool view() {
    if (roomData.isEmpty)
      return false;
    else
      return true;
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
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DumyScreen()));
              },
              child: Icon(Icons.add))
        ],
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
      body: Column(
        children: [
          ///for home
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
                              Obx(() {
                                return Expanded(
                                  flex: 1,
                                  child: roomData.isEmpty
                                      ? Container()
                                      : Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
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
                                                      "roomType":
                                                          dropdownvalue.value,
                                                      "roomName":
                                                          roomNameText.text,
                                                      "icon":
                                                          dropdownvalue.value,
                                                    });
                                                    roomNameText.clear();
                                                    Get.back();
                                                  },
                                                  cancelTextColor: Colors.black,
                                                  confirmTextColor:
                                                      Colors.black,
                                                  buttonColor:
                                                      Color(0xFF029b93),
                                                  barrierDismissible: false,
                                                  content: Column(
                                                    children: [
                                                      Obx(
                                                        () {
                                                          return DropdownButton(
                                                            value: dropdownvalue
                                                                .value,
                                                            icon: Icon(Icons
                                                                .keyboard_arrow_down),
                                                            items: items.map(
                                                                (String items) {
                                                              return DropdownMenuItem(
                                                                  value: items,
                                                                  child: Text(
                                                                      items));
                                                            }).toList(),
                                                            onChanged:
                                                                (newValue) {
                                                              dropdownvalue
                                                                      .value =
                                                                  newValue
                                                                      .toString();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      TextField(
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Enter Name',
                                                            hintText:
                                                                'Enter Name'),
                                                        controller:
                                                            roomNameText,
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
                                );
                              })
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
                          height: double.infinity,
                          width: double.infinity,
                          child: ListView(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Obx(() {
                                    return Column(
                                      children: [
                                        roomData.isEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 100),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print("after");
                                                    print("before");
                                                    Get.defaultDialog(
                                                      title: "Add Rooms",
                                                      middleText:
                                                          "Hello world!",
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
                                                            dropdownvalue
                                                                .value);
                                                        roomData.add({
                                                          "roomType":
                                                              dropdownvalue
                                                                  .value,
                                                          "roomName":
                                                              roomNameText.text,
                                                          "icon": dropdownvalue
                                                              .value,
                                                        });
                                                        roomNameText.clear();
                                                        Get.back();
                                                      },
                                                      cancelTextColor:
                                                          Colors.black,
                                                      confirmTextColor:
                                                          Colors.black,
                                                      buttonColor:
                                                          Color(0xFF029b93),
                                                      barrierDismissible: false,
                                                      content: Column(
                                                        children: [
                                                          Obx(
                                                            () {
                                                              return DropdownButton(
                                                                value:
                                                                    dropdownvalue
                                                                        .value,
                                                                icon: Icon(Icons
                                                                    .keyboard_arrow_down),
                                                                items: items
                                                                    .map((String
                                                                        items) {
                                                                  return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child: Text(
                                                                          items));
                                                                }).toList(),
                                                                onChanged:
                                                                    (newValue) {
                                                                  dropdownvalue
                                                                          .value =
                                                                      newValue
                                                                          .toString();
                                                                },
                                                              );
                                                            },
                                                          ),
                                                          TextField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Enter Name',
                                                                hintText:
                                                                    'Enter Name'),
                                                            controller:
                                                                roomNameText,
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
                                              )
                                            : Container(),
                                        roomData.isEmpty
                                            ? Text("No Rooms Click + to add")
                                            : Container(),
                                      ],
                                    );
                                  }),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    // color: Colors.deepPurple,
                                    height: 300,
                                    // / color: Colors.yellow,
                                    child: Obx(() {
                                      return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 150,
                                                  childAspectRatio: 3 / 3,
                                                  crossAxisSpacing: 0,
                                                  mainAxisSpacing: 10),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          itemCount: roomData.length,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                qrController.indexNum.value =
                                                    index;
                                                Get.to(RoomScreen());
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: CustomTheme
                                                          .loginGradientEnd,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    height: 100,
                                                    width: 200,
                                                    child: Center(
                                                      child: Image.asset(
                                                        "assets/" +
                                                            roomData[index]
                                                                ['icon'] +
                                                            ".png",
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(roomData[index]
                                                            ['roomName']
                                                        .toString()),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }),
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

          ///for commercial
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
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
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
    );
  }
}
