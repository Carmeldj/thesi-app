import 'package:hive_ce_flutter/adapters.dart';

class User extends HiveObject {
  String? id;
  String? username;
  String? email;
  String? profilePicture;
  String? phoneNumber;
  String? bio;
  String? type;
  String? role;

  User({
    this.id,
    this.username,
    this.email,
    this.bio,
    this.phoneNumber,
    this.profilePicture,
    this.type,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profile_picture'] as String?,
      phoneNumber: json['phone_number'] as String?,
      bio: json['bio'] as String?,
      type: json['type'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profile_picture': profilePicture,
      'phone_number': phoneNumber,
      'bio': bio,
      'type': type,
      'role': role,
    };
  }
}
