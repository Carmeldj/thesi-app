import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:thesis_app/constants/environement_var.dart';
import 'package:thesis_app/models/user.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  final myBox = Hive.box('db');
  final dio = Dio();
  StreamCubit() : super(StreamInitial());

  void createUserStream() async {
    emit(StreamLoading());
    try {
      final user = myBox.get("user") as User;
      final accessToken = user.accessToken;
      final userId = user.id;
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.post("$apiUrl/livestream/$userId");

      log(response.data);
    } catch (e) {
      emit(StreamFailure('Failed to create stream'));
    }
  }
}
