import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';
import 'package:techvillaautomation/ui/drawer/contact_us.dart';
import 'package:techvillaautomation/ui/drawer/stats.dart';
import '../theme.dart';
import 'package:techvillaautomation/model/user.dart';

import 'drawer/profile.dart';

class HomeScreen extends GetWidget<FirebaseController> {
 final dropdownvalue = 'Apple'.obs;
  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];
  final TextEditingController _dialogueBoxText = TextEditingController();



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
      body: Column(
        children: [
          ///for home
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Center(
                          child: Text(
                            "Home Automation",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                          height: double.infinity,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(dropdownvalue);
                                  Get.defaultDialog(
                                      title: "Add Rooms",
                                      middleText: "Hello world!",
                                      //  backgroundColor: Colors.green,
                                      // titleStyle: TextStyle(color: Colors.white),
                                      //middleTextStyle: TextStyle(color: Colors.white),
                                      textConfirm: "Confirm",
                                      textCancel: "Cancel",
                                      //cancelTextColor: Colors.white,
                                      //confirmTextColor: Colors.white,
                                      //buttonColor: Colors.red,
                                      barrierDismissible: false,
                                      content: Column(
                                        children: [
                                          TextField(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Enter Name',
                                                hintText: 'Enter Name'),
                                            controller: _dialogueBoxText,
                                          ),
                                          DropdownButton(
                                            value: dropdownvalue,
                                            icon: Icon(Icons.keyboard_arrow_down),
                                            items: items.map((String items) {
                                              return DropdownMenuItem(value: items, child: Text(items));
                                            }).toList(),
                                            onChanged: (newValue)
                                            {

                                           dropdownvalue(newValue.toString()) ;
                                            },
                                          ),
                                        ],
                                      ));
                                  print(dropdownvalue);
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
                              Text("No Rooms Click + to add")
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
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Container(
                            // child: Column(
                            //   children: [
                            //
                            //     RaisedButton(
                            //       child: Text('Create Data'),
                            //       color: Colors.redAccent,
                            //       onPressed: () {
                            //         controller.createData();
                            //       },
                            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            //     ),
                            //     RaisedButton(
                            //       child: Text('read data'),
                            //       color: Colors.redAccent,
                            //       onPressed: () {
                            //         controller.readData();
                            //       },
                            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            //     ),
                            //     RaisedButton(
                            //       child: Text('update data'),
                            //       color: Colors.redAccent,
                            //       onPressed: () {
                            //         controller.updateData();
                            //       },
                            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            //     ),
                            //     RaisedButton(
                            //       child: Text('delt data'),
                            //       color: Colors.redAccent,
                            //       onPressed: () {
                            //         controller.deleteData();
                            //       },
                            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            //     ),
                            //   ],
                            //
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
