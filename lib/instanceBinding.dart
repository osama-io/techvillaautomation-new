import 'package:get/get.dart';
import 'controllers/firebase_controllers.dart';

class InstanceBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FirebaseController>(() => FirebaseController());
  }

}