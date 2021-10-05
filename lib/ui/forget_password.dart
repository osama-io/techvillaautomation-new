import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';
import 'package:techvillaautomation/services/helper.dart';

import '../theme.dart';

class ForgetPasswordScreen extends GetWidget<FirebaseController> {
  final TextEditingController _emailController = new TextEditingController();
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
        title: Text("Forget Password?"),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
              child: TextFormField(
                validator: validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: "Email"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                      CustomTheme.loginGradientEnd,
                      CustomTheme.loginGradientStart
                    ],
                    begin: FractionalOffset(0.2, 0.2),
                    end: FractionalOffset(1.0, 1.0),
                    stops: <double>[0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: MaterialButton(
                onPressed: () {
                  submit();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
                height: 5.h,
                minWidth: 100,
              ),
            ),
          )
        ],
      ),
    );
  }

  void submit() {
    controller.forgetPassword(_emailController.text);
  }
}
