import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:techvillaautomation/dumy_room.dart';
import 'package:techvillaautomation/model/RoomModel.dart';

class DumyScreen extends StatefulWidget {
  @override
  _DumyScreenState createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('data').child('S401');

  final dbRef = FirebaseDatabase.instance.reference().child('users');
  final ref = FirebaseDatabase.instance;
  late List roomList;

  String userId = "";
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  loadUser() {
    final User? user = _auth.currentUser;
    userId = user!.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    var query = dbRef.child(userId).child('Rooms');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Rooms'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: dbRef.child(userId).child('Rooms').onValue,
                builder: (context, AsyncSnapshot<Event> snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading');
                  } else if (!snapshot.data!.snapshot.exists) {
                    return Center(child: Text('No room found create'));
                  } else {
                    Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();
                    roomList =list;
                  //  roomData.value = list;
                    print(list);
                    print("now");

                    print(roomList);
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: list.length,
                      padding: EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DumyRoom(
                                          index: index,
                                          name: list[index]['Room Name'],
                                          roomId: list[index]['roomId'],
                                        )));
                          },
                          child: ListTile(
                            title: Text(list[index]['Room Name']),
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              child: Image(
                                  image: AssetImage(
                                      list[index]['Room Name'] == "Room"
                                          ? 'assets/Room.png'
                                          : 'assets/Room.png')),
                              radius: 15,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
