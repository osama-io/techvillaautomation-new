import 'package:techvillaautomation/model/user.dart';

const FINISHED_ON_BOARDING = 'finishedOnBoarding';
const COLOR_PRIMARY = 0xFF4549BC;
const FACEBOOK_BUTTON_COLOR = 0xFF415893;
const USERS = 'users';

enum ImageSource {
  /// Opens up the device camera, letting the user to take a new picture.
  camera,

  /// Opens the user's photo gallery.
  gallery,
}

class Constants {
  static UserModel?  userData;
}
