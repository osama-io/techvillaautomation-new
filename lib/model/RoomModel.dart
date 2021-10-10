import 'package:get/get.dart';

class RoomModel extends GetxController {
  String? roomType;
  String? roomName;
  String? icon;

  RoomModel(this.roomType, this.roomName, this.icon);
}

List<RoomModel> room = roomData
    .map((item) => RoomModel(
        item["roomType"], item['roomName'].toString(), iconSelector(item["roomType"])))
    .toList();

var roomData = [].obs;

String? iconSelector (String roomType)

{
  if( roomType == "Room" )
    {
      return "Room.png";
    }
  else if( roomType == "Main Gate"  )
    {
      return "Main Gate.png";
    }
  else if( roomType == "Water Motor"  )
  {
    return "Water Motor.png";
  }else if( roomType == "Tv Lounge"  )
  {
    return "Tv Lounge.png";
  }
}