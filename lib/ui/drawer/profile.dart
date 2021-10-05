import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';

import '../../theme.dart';

class ProfileScreen extends GetWidget<FirebaseController> {
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
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
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          // profile picture
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, top: 32, right: 8, bottom: 8),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey.shade400,
                  child: ClipOval(
                    child: SizedBox(
                      width: 170,
                      height: 170,
                      child: Image.asset("assets/placeholder.jpg"),
                      // child:  Image.network(
                      //     controller.imageUrl?.toString() ?? "i ",
                      // fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  right: 0,
                  child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.camera_alt),
                      mini: true,
                      onPressed: () {}),
                )
              ],
            ),
          ),
          //
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(controller.userName?.toString() ?? "abc"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("${controller.userEmail}"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("${controller.userUid}"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // _onCameraClick() {
  //   final action = CupertinoActionSheet(
  //     message: Text(
  //       "Add profile picture",
  //       style: TextStyle(fontSize: 15.0),
  //     ),
  //     actions: <Widget>[
  //       CupertinoActionSheetAction(
  //         child: Text("Choose from gallery"),
  //         isDefaultAction: false,
  //         onPressed: () async {
  //           Navigator.pop(context);
  //           PickedFile? image =
  //           await _imagePicker.getImage(source: ImageSource.gallery);
  //           if (image != null)
  //             setState(() {
  //               _image = File(image.path);
  //             });
  //         },
  //       ),
  //       CupertinoActionSheetAction(
  //         child: Text("Take a picture"),
  //         isDestructiveAction: false,
  //         onPressed: () async {
  //           Navigator.pop(context);
  //           PickedFile? image =
  //           await _imagePicker.getImage(source: ImageSource.camera);
  //           if (image != null)
  //             setState(() {
  //               _image = File(image.path);
  //             });
  //         },
  //       )
  //     ],
  //     cancelButton: CupertinoActionSheetAction(
  //       child: Text("Cancel"),
  //       onPressed: () {
  //         Get.back();
  //       },
  //     ),
  //   );
  //   showCupertinoModalPopup(context: context, builder: (context) => action);
  // }
}
