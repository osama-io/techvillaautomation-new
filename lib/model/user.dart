import 'dart:io';

class UserModel {
  String? userUid;
  String? email;

  String? name;

  String? num;
  String? profilePictureURL;

  UserModel(
      {this.email = '',
      this.num = '',
      this.name = '',
      this.userUid = '',
      this.profilePictureURL = ''});

  factory UserModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new UserModel(
        email: parsedJson['Email'] ?? '',
        num: parsedJson['Contact'],
        name: parsedJson['Name'] ?? '',
        userUid: parsedJson['Id'] ?? parsedJson['UserID'] ?? '',
        profilePictureURL: parsedJson['ProfilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': this.email,
      'Name': this.name,
      'Id': this.userUid,
      'ProfilePictureURL': this.profilePictureURL,
      'Contact': this.num
    };
  }
}


