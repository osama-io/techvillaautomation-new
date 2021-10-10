import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrController extends GetxController {
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
    print(result.value);

  }
}
