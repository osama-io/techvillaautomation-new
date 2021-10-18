import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:techvillaautomation/controllers/qr_controller.dart';
import 'package:techvillaautomation/model/RoomModel.dart';

import '../theme.dart';

class RoomModel extends GetxController {
  String? roomType;
  String? roomName;
  String? icon;

  RoomModel(this.roomType, this.roomName, this.icon);
}

//  RoomModel? fromsnapshot(DocumentSnapshot snapshot) {
//  RoomModel roomModel = RoomModel(snapshot["roomType"], snapshot['roomName'], snapshot["roomType"]);
//
//  return roomModel;
//
// }
//
List<RoomModel> room = roomData
    .map((item) => RoomModel(item["roomType"], item['roomName'].toString(),
        iconSelector(item["roomType"])))
    .toList();

var roomData = [].obs;


String? iconSelector(String roomType) {
  if (roomType == "Room") {
    return "Room.png";
  } else if (roomType == "Main Gate") {
    return "Main Gate.png";
  } else if (roomType == "Water Motor") {
    return "Water Motor.png";
  } else if (roomType == "Tv Lounge") {
    return "Tv Lounge.png";
  }
}
