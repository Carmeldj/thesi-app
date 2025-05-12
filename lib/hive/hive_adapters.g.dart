// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String?,
      username: fields[1] as String?,
      email: fields[2] as String?,
      bio: fields[5] as String?,
      phoneNumber: fields[4] as String?,
      profilePicture: fields[3] as String?,
      type: fields[6] as String?,
      role: fields[7] as String?,
      accessToken: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.profilePicture)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.bio)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LiveAdapter extends TypeAdapter<Live> {
  @override
  final typeId = 1;

  @override
  Live read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Live(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      members: (fields[2] as List?)?.cast<String>(),
      updateAt: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Live obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
