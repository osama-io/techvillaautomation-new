import 'dart:io';

class User {
  String userID;
  String email;

  String name;

  String num;
  String profilePictureURL;

  User(
      {this.email = '',
      this.num = '',
      this.name = '',
      this.userID = '',
      this.profilePictureURL = ''});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        num: parsedJson['num'],
        name: parsedJson['name'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'name': this.name,
      'id': this.userID,
      'profilePictureURL': this.profilePictureURL,
      'num': this.num
    };
  }
}
