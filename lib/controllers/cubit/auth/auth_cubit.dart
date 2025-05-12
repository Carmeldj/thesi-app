import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:thesis_app/constants/environement_var.dart';
import 'package:thesis_app/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final dio = Dio();
  final myBox = Hive.box('db');
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());

    try {
      final response = await dio.post(
        '$apiUrl/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        emit(AuthSucess());
        final user = User.fromJson(response.data['user']);
        myBox.put('user', user);
        myBox.put('token', response.data['token']);
      }
    } on DioException catch (e) {
      emit(AuthFailure(e.message!));
    }
  }
}
