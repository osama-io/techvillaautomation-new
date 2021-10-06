import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:techvillaautomation/constants.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';
import 'package:techvillaautomation/main.dart';

import 'package:techvillaautomation/services/helper.dart';
import 'package:techvillaautomation/ui/forget_password.dart';
import 'package:techvillaautomation/ui/home_screen.dart';
import 'package:techvillaautomation/model/user.dart';
import 'package:techvillaautomation/ui/signup.dart';

import '../theme.dart';

class LoginScreen extends GetWidget<FirebaseController> {
  // final controllerr = Get.put(LoginController());

  final GlobalKey<FormState> _key = new GlobalKey();
  final AutovalidateMode _validate = AutovalidateMode.disabled;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var _obscureTextPassword = true.obs;
  //final _obscureTextPassword = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                "assets/logo1.png",
                height: 25.h,
                width: 25.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  children: [
                    Text(
                      "Tech Villa Automation ",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      "Its all about being smart",
                      style:
                          TextStyle(fontSize: 12.0.sp, color: Colors.black45),
                    ),
                  ],
                ),
              ),

              ///email @ password
              Container(
                width: 90.w,
                child: Form(
                  key: _key,
                  autovalidateMode: _validate,
                  child: Column(
                    children: <Widget>[
                      ///email
                      TextFormField(
                        validator: validateEmail,
                        // onSaved: (val) => email = val!,
                        controller: _emailController,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                      ),

                      ///password

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Obx(() {
                          return TextFormField(
                            controller: _passwordController,
                            validator: validatePassword,
                            // onSaved: (val) => password = val!,
                            obscureText: _obscureTextPassword.value,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _toggleLogin();
                                    print(_obscureTextPassword.value);
                                  },
                                  child: Obx(() {
                                    return Icon(
                                      _obscureTextPassword.value
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.password_sharp,
                                      size: 20.0,
                                      color: Colors.black,
                                    );
                                  }),
                                ),
                                labelText: "Password"),
                          );
                        }),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => ForgetPasswordScreen(),
                            );
                          },
                          child: Text("Forgot Password?"),
                        ),
                      ),

                      /// Login button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
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
                                signin();
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.sp),
                              ),
                              height: 5.h,
                              minWidth: 100,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),

              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User?",
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(SignupPage());
                        },
                        child: Text(
                          " Register Now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Or",
                    ),
                  ),
                  Text(
                    "Use Other Methods",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(controller.userEmail);
                          },
                          child: Image.asset(
                            "assets/facebook.png",
                            height: 5.h,
                            width: 5.h,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.google_signIn();
                          },
                          child: Image.asset(
                            "assets/google-plus.png",
                            height: 5.h,
                            width: 5.h,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signin() {
    controller.login(_emailController.text, _passwordController.text);
  }

  void _toggleLogin() {
    _obscureTextPassword.value = !_obscureTextPassword.value;
  }
}
