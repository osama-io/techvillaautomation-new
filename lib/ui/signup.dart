import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:techvillaautomation/controllers/firebase_controllers.dart';
import 'package:techvillaautomation/services/helper.dart';
import '../theme.dart';

// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   bool _obscureTextPassword = true;
//
//   GlobalKey<FormState> _key = new GlobalKey();
//   AutovalidateMode _validate = AutovalidateMode.disabled;
//   String? name, email, password, confirmPassword, num;
//
//   TextEditingController _nameController = new TextEditingController();
//   TextEditingController _emailController = new TextEditingController();
//   TextEditingController _passwordController = new TextEditingController();
//   TextEditingController _confirmPasswordController =
//       new TextEditingController();
//   TextEditingController _numController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: <Color>[
//                   CustomTheme.loginGradientEnd,
//                   CustomTheme.loginGradientStart
//                 ],
//                 begin: FractionalOffset(0.2, 0.2),
//                 end: FractionalOffset(1.0, 1.0),
//                 stops: <double>[0.1, 1.0],
//                 tileMode: TileMode.clamp),
//           ),
//         ),
//         title: Text("Register New User"),
//         leading: GestureDetector(
//           onTap: () {},
//           child: Icon(
//             Icons.arrow_back,
//           ),
//         ),
//       ),
//       body: ListView(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _key,
//                 autovalidateMode: _validate,
//                 child: Column(
//                   children: <Widget>[
//                     ///Name
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         validator: validateName,
//                         onSaved: (val) => name = val,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.person_outlined),
//                             border: OutlineInputBorder(),
//                             labelText: "Name"),
//                       ),
//                     ),
//
//                     ///Email
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         validator: validateEmail,
//                         onSaved: (val) => email = val,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.mail),
//                             border: OutlineInputBorder(),
//                             labelText: "Email"),
//                       ),
//                     ),
//
//                     ///password
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         validator: (val) => validateConfirmPassword(
//                             _passwordController.text, val),
//                         onSaved: (val) => confirmPassword = val,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.lock),
//                             border: OutlineInputBorder(),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleLogin,
//                               child: Icon(
//                                 _obscureTextPassword
//                                     ? Icons.remove_red_eye_rounded
//                                     : Icons.password_sharp,
//                                 size: 15.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             labelText: "Password"),
//                       ),
//                     ),
//
//                     ///Confirm password
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         obscureText: _obscureTextPassword,
//                         validator: (val) => validateConfirmPassword(
//                             _passwordController.text, val),
//                         onSaved: (val) => confirmPassword = val,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.lock),
//                             border: OutlineInputBorder(),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleLogin,
//                               child: Icon(
//                                 _obscureTextPassword
//                                     ? Icons.remove_red_eye_rounded
//                                     : Icons.password_sharp,
//                                 size: 15.0,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             labelText: "Confirm Password"),
//                       ),
//                     ),
//
//                     ///Contact
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         validator: validateMobile,
//                         onSaved: (val) => num = val,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.contact_phone),
//                             border: OutlineInputBorder(),
//                             labelText: "Contact number"),
//                       ),
//                     ),
//
//                     /// Login button
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               colors: <Color>[
//                                 CustomTheme.loginGradientEnd,
//                                 CustomTheme.loginGradientStart
//                               ],
//                               begin: FractionalOffset(0.2, 0.2),
//                               end: FractionalOffset(1.0, 1.0),
//                               stops: <double>[0.0, 1.0],
//                               tileMode: TileMode.clamp),
//                         ),
//                         child: MaterialButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Register",
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 13.sp),
//                           ),
//                           height: 5.h,
//                           minWidth: 100,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _toggleLogin() {
//     setState(() {
//       _obscureTextPassword = !_obscureTextPassword;
//     });
//   }
// }

class SignupPage extends GetWidget<FirebaseController> {
  var _obscureTextPassword = true.obs;
  final GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final TextEditingController _numController = new TextEditingController();
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
        title: Text("Register New User"),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _key,
                autovalidateMode: _validate,
                child: Column(
                  children: <Widget>[
                    ///Name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: _nameController,
                        validator: validateName,
                        //onSaved: (val) => name = val,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outlined),
                            border: OutlineInputBorder(),
                            labelText: "Name"),
                      ),
                    ),

                    ///Email
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: validateEmail,
                        //onSaved: (val) => email = val,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(),
                            labelText: "Email"),
                      ),
                    ),

                    ///password
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Obx(() {
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureTextPassword.value,
                          validator: (val) => validateConfirmPassword(
                              _passwordController.text, val),
                          // onSaved: (val) => confirmPassword = val,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Obx(() {
                                    return Icon(
                                      _obscureTextPassword.value
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.password_sharp,
                                      size: 20.0,
                                      color: Colors.black,
                                    );
                                  })),
                              labelText: "Password"),
                        );
                      }),
                    ),

                    ///Confirm password
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Obx(() {
                          return TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureTextPassword.value,
                            validator: (val) => validateConfirmPassword(
                                _passwordController.text, val),
                            // onSaved: (val) => confirmPassword = val,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                suffixIcon: GestureDetector(
                                    onTap: _toggleLogin,
                                    child: Obx(() {
                                      return Icon(
                                        _obscureTextPassword.value
                                            ? Icons.remove_red_eye_rounded
                                            : Icons.password_sharp,
                                        size: 20.0,
                                        color: Colors.black,
                                      );
                                    })),
                                labelText: "Confirm Password"),
                          );
                        })),

                    ///Contact
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: _numController,
                        validator: validateMobile,
                        // onFieldSubmitted: (_) => _signUp(),
                        //onSaved: (val) => num = val,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.contact_phone),
                            border: OutlineInputBorder(),
                            labelText: "Contact number"),
                      ),
                    ),

                    /// Signup button
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
                            _signUp();
                          },
                          child: Text(
                            "Register",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.sp),
                          ),
                          height: 5.h,
                          minWidth: 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _register() {
    controller.signUp(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _confirmPasswordController.text,
        _numController.text);
  }

  /// use for validation
  _signUp() async {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState!.save();
      await _register();
    } else {
      print(_validate);

      _validate = AutovalidateMode.onUserInteraction;
    }
  }

  void _toggleLogin() {
    _obscureTextPassword.value = !_obscureTextPassword.value;
  }
}
