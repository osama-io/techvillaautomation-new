import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:techvillaautomation/ui/home_screen.dart';
import 'package:techvillaautomation/ui/login.dart';
//import 'package:techvilla/model/user.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseController extends GetxController {
  //static FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;



  final databaseReference = FirebaseDatabase.instance.reference();

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  ); //initialization with scope as Email

  Rxn<User> _firebaseUser = Rxn<User>();


  String? get userUid => _firebaseUser.value?.uid;
  String? get userEmail => _firebaseUser.value?.email;
  String? get userName => _firebaseUser.value?.displayName;
  String? get imageUrl => _firebaseUser.value?.photoURL;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }



  // function to createuser, login and sign out user

  void signUp(String name, String email, String password,
      String confirmPassword, String num) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("users");

    Map<String, String> userdata = {
      "Name": name,
      "Email": email,
      "Contact": num
    };

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value)  => Get.offAll(HomeScreen())).
    catchError(
      (onError) => Get.snackbar(
          "Error while creating account ", onError.message,
          duration: 1.seconds),
    );
  }

  // login function
  void login(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => Get.offAll(
            HomeScreen(),
          ),
        )
        .catchError((onError) {
      String message = 'Couldn\'t sign up';
      switch (onError.code) {
        case 'wrong-password':
          message = 'Wrong password!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'user-not-found':
          message = 'No user corresponding to the given email address';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }

      Get.snackbar(
        "Error while sign in ",
        message,
        animationDuration: 200.milliseconds,
      );
    });
  }

  // sign out function
  void signOut() async {
    await _auth.signOut().then(
          (value) => Get.offAll(
            LoginScreen(),
          ),
        );
  }

  // forget password function
  void forgetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(LoginScreen());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError((onError) {
      String message = 'Couldn\'t sign up';
      switch (onError.code) {
        case 'wrong-password':
          message = 'Wrong password!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'user-not-found':
          message = 'This email is not registered';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      Get.snackbar(
        "Error while sign in ",
        message,
        animationDuration: 200.milliseconds,
      );
    });
  }

//sign in with google function
  void google_signIn() async {
    final GoogleSignInAccount? googleUser = await googleSignIn
        .signIn(); //calling signIn method // this will open a dialog pop where user can select his email id to signin to the app

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, //create a login credential
        accessToken: googleAuth.accessToken);

    final User user = (await _auth.signInWithCredential(credential).then(
        (value) async => await Get.offAll(
            HomeScreen()))); //if credential success, then using _auth signed in user data will be stored
  }

  //sign out with google function
  void google_signOut() async {
    await googleSignIn.signOut().then((value) => Get.offAll(LoginScreen()));
  }

  void createData(){
    databaseReference.child("flutterDevsTeam1").set({
      'name': 'Deepak Nishad',
      'description': 'Team Lead'
    });
    databaseReference.child("flutterDevsTeam2").set({
      'name': 'Yashwant Kumar',
      'description': 'Senior Software Engineer'
    });
    databaseReference.child("flutterDevsTeam3").set({
      'name': 'Akshay',
      'description': 'Software Engineer'
    });
    databaseReference.child("flutterDevsTeam4").set({
      'name': 'Aditya',
      'description': 'Software Engineer'
    });
    databaseReference.child("flutterDevsTeam5").set({
      'name': 'Shaiq',
      'description': 'Associate Software Engineer'
    });
    databaseReference.child("flutterDevsTeam6").set({
      'name': 'Mohit',
      'description': 'Associate Software Engineer'
    });
    databaseReference.child("flutterDevsTeam7").set({
      'name': 'Naveen',
      'description': 'Associate Software Engineer'
    });
  }
  void readData(){
    databaseReference.child("S401").once().then((DataSnapshot snapshot) {
      print(' ${snapshot.value}');

    });
  }

  void updateData(){
    databaseReference.child('flutterDevsTeam1').update({
      'description': 'CEO'
    });
    databaseReference.child('flutterDevsTeam2').update({
      'description': 'Team Lead'
    });
    databaseReference.child('flutterDevsTeam3').update({
      'description': 'Senior Software Engineer'
    });
  }
  void deleteData(){
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }

  // static Future<String?> firebaseCreateNewUser(User user) async =>
  //     await firestore
  //         .collection('user')
  //         .doc(user.userID)
  //         .set(user.toJson())
  //         .then((value) => null, onError: (e) => e);
}
