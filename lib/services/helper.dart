import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


String? validateName(String? value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value?.length == 0) {
    return "Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String? validateMobile(String? value) {
  String pattern = r'(^\+?[0-9]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value?.length == 0) {
    return "Mobile phone number is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Mobile phone number must contain only digits";
  }
  return null;
}

String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6)
    return 'Password must be more than 5 characters';
  else
    return null;
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value ?? ''))
    return 'Enter Valid Email';
  else
    return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return 'Password doesn\'t match';
  } else if (password!.isEmpty) {
    return 'Password is required';
  } else if (confirmPassword!.isEmpty) {
    return 'Confirm password is required';
  } else if (password.length < 6) {
    return 'Password must b greater then 6 digits';
  } else {
    return null;
  }
}

// //helper method to show progress
// late ProgressDialog progressDialog;
//
// showProgress(BuildContext context, String message, bool isDismissible) async {
//   progressDialog = new ProgressDialog(context,
//       type: ProgressDialogType.Normal, isDismissible: isDismissible);
//   progressDialog.style(
//       message: message,
//       borderRadius: 10.0,
//       backgroundColor: Colors.red,
//       progressWidget: Container(
//         padding: EdgeInsets.all(8.0),
//         child: CircularProgressIndicator(
//           backgroundColor: Colors.white,
//           valueColor: AlwaysStoppedAnimation(Colors.red),
//         ),
//       ),
//       elevation: 10.0,
//       insetAnimCurve: Curves.easeInOut,
//       messageTextStyle: TextStyle(
//           color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
//   await progressDialog.show();
// }
