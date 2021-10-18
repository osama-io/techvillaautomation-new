import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techvillaautomation/controllers/qr_controller.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class DumyRoom extends StatefulWidget {

  int index ;
  String name , roomId;
   DumyRoom({required this.name , required this.roomId, required this.index});

  @override
  _DumyRoomState createState() => _DumyRoomState();
}

class _DumyRoomState extends State<DumyRoom> {

  String code = "" ;
  String userId = ""  ;

  FirebaseAuth _auth = FirebaseAuth.instance ;

  late DatabaseReference reference =  FirebaseDatabase.instance.reference();
  final dbRef = FirebaseDatabase.instance.reference().child('users');



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser () ;
  }

  loadUser (){
    final User? user = _auth.currentUser ;
    userId = user!.uid.toString() ;
  }

  final qrController = Get.put(QrController());

  final result = "heloooo".obs;
  var indexNum = 1.obs;

  Future scanQR() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? cameraScanResult = await scanner.scan();
      result.value = cameraScanResult!;
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        String? cameraScanResult = await scanner.scan();
        result.value = cameraScanResult!;
      }
    }
    setState(() {
      code = result.value.toString() ;
      update(code);
    });
    print("myvalue"+result.value);

  }

  void update(String code)async{

    await reference.child('data').child(code).once().then((value){
    //  print(value.value.toString());
      print(value.value[0]['deviceName'].toString());
     // print(value.value[1]['value'].toString());

      print('my value'+value.value.length.toString());
      for(int i = 0 ; i < value.value.length ; i++){
        print('for loop'+i.toString());

        String msgId = dbRef.child(userId).child('Rooms').child(widget.roomId).child(widget.roomId).push().key;

        dbRef.child(userId).child('Rooms').child(widget.roomId).child(widget.roomId).child(msgId).set({
          'deviceName' : value.value[i]['deviceName'].toString(),
          'value' : value.value[i]['value'],
          'id' : msgId.toString(),
        }).onError((error, stackTrace) {
          print(error.toString() + stackTrace.toString());
        });
      }

    }).whenComplete((){
      print('completed');
    }) ;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  scanQR() ;
                 // qrController.scanQR();
                },
                child: Icon(Icons.scanner),
              )),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: StreamBuilder(
              stream: dbRef.child(userId).child('Rooms').child(widget.roomId).child(widget.roomId).onValue,
              builder: (context, AsyncSnapshot<Event> snapshot){
                if(!snapshot.hasData){
                  return Text('Loading');
                }else if(!snapshot.data!.snapshot.exists){
                  return Center(child: Text('No data found, please scnae'));
                }else {
                  Map<dynamic, dynamic> map = snapshot.data!.snapshot.value;
                  List<dynamic> list = [];
                  list.clear();
                  list = map.values.toList();

                  print('ListValue'+list.toString());
                  print("listlenght"+list[widget.index].length.toString());
                 // var val = list[0] ;
                  if(!snapshot.hasData){
                    return Center(child: Text('Loading'));
                  }else if(list == null ){
                    return Center(child: Text('No data found, please scbae'));

                  }else {
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                       // print( list[0][0]['id'].toString());
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(radius: 15 , backgroundColor: Colors.blue,),
                              title: Text(
                                //  index.toString()
                                  list[index]['deviceName'].toString()+' value: '+list[index]['value'].toString()
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: CupertinoSwitch(
                                      value: list[index]['value'] ,
                                      onChanged: (bool val) {
                                        // update();
                                        bool value = val ;
                                        dbRef.child(userId).child('Rooms').child(widget.roomId).child(widget.roomId).child(list[index]['id']).set({
                                          'deviceName' : list[index]['deviceName'],
                                          'value' : value,
                                          'id' : list[index]['id'],
                                        }).then((value){
                                          print('update successfully');
                                        });


                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        dbRef.child(userId).child('Rooms').child(widget.roomId).child(widget.roomId).child(list[index]['id']).remove().then((value){
                                          print('item removed');
                                        }).onError((error, stackTrace){
                                          print('error'+error.toString());
                                        });
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            ),

                          ],
                        );
                        return InkWell(
                          onTap: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => DumyRoom( name : list[index]['Room Name'] , roomId: list[index]['roomId'],)));
                          },
                          child: ListTile(
                            title: Text(
                                list[widget.index][index]['deviceName']
                            ),
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              radius: 15,backgroundColor: Colors.blue,),
                          ),
                        );
                      },
                    );
                  }

                }

              },
            ),
          ),

        ],
      ),
    );
  }
}


