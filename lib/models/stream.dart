import 'package:hive_ce_flutter/adapters.dart';

class Live extends HiveObject {
  String? id;
  String? userId;
  List<String>? members;
  String? updateAt;

  Live({this.id, this.userId, this.members, this.updateAt});

  factory Live.fromJson(Map<String, dynamic> json) {
    return Live(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      members: json['email'] as List<String>?,
      updateAt: json['updateAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'members': members,
      'updateAt': updateAt,
    };
  }
}
