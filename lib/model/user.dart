import 'dart:io';

class UserModel {
  String? userID;
  String? email;

  String? name;

  String? num;
  String? profilePictureURL;

  UserModel(
      {this.email = '',
      this.num = '',
      this.name = '',
      this.userID = '',
      this.profilePictureURL = ''});

  factory UserModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new UserModel(
        email: parsedJson['Email'] ?? '',
        num: parsedJson['Contact'],
        name: parsedJson['Name'] ?? '',
        userID: parsedJson['Id'] ?? parsedJson['UserID'] ?? '',
        profilePictureURL: parsedJson['ProfilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': this.email,
      'Name': this.name,
      'Id': this.userID,
      'ProfilePictureURL': this.profilePictureURL,
      'Contact': this.num
    };
  }
}


List<String> room =["1","2","3","4","5"];
