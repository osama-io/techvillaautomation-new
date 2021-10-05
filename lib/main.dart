import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'instanceBinding.dart';
import 'is_signed_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          initialBinding: InstanceBinding(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: AnimatedSplashScreen(
              duration: 2000,
              splash: "assets/logo1.png",
              splashIconSize: 200,
              nextScreen: IsSignedIn(),
              splashTransition: SplashTransition.scaleTransition,
              pageTransitionType: PageTransitionType.fade,
              backgroundColor: Colors.white),
        );
      },
    );
  }
}
