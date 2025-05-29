import 'package:hive_ce_flutter/adapters.dart';

class User extends HiveObject {
  String? id;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? profilePicture;
  String? phoneNumber;
  String? bio;
  String? type;
  String? role;
  String? accessToken;
  String? streamToken;

  User({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.email,
    this.bio,
    this.phoneNumber,
    this.profilePicture,
    this.type,
    this.role,
    this.accessToken,
    this.streamToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profile_picture'] as String?,
      phoneNumber: json['phone_number'] as String?,
      bio: json['bio'] as String?,
      type: json['type'] as String?,
      role: json['role'] as String?,
      accessToken: json['access_token'] as String?,
      streamToken: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'profile_picture': profilePicture,
      'phone_number': phoneNumber,
      'bio': bio,
      'type': type,
      'role': role,
      'access_token': accessToken,
      'token': streamToken,
    };
  }
}
