import 'package:techvillaautomation/ui/home_screen.dart';
import 'package:techvillaautomation/ui/login.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'controllers/firebase_controllers.dart';

class IsSignedIn extends GetWidget<FirebaseController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<FirebaseController>().isLoggedIn.value
          ? HomeScreen()
          : LoginScreen();
    });
  }
}
