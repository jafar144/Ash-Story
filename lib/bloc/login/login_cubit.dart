import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/login/login_state.dart';
import 'package:submission_intermediate/data/api/api_service.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;
  final PreferencesHelper preferencesHelper;

  LoginCubit(
    this.apiService,
    this.preferencesHelper,
  ) : super(Idle());

  Future login(
    String email,
    String password,
  ) async {
    emit(LoadingLogin());
    try {
      final result = await apiService.login(email, password);
      if (result.error == false) {
        await preferencesHelper.setTokenLogin(result.loginResult.token);
        emit(SuccessLogin());
      } else {
        emit(FailedLogin(message: result.message));
      }
    } on SocketException catch (e) {
      emit(FailedLogin(message: e.message));
    } catch (e) {
      emit(FailedLogin(message: e.toString()));
    }
  }
}
