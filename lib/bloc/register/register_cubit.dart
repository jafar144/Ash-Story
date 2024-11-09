import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/register/register_state.dart';
import 'package:submission_intermediate/data/api/api_service.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final ApiService apiService;

  RegisterCubit(this.apiService) : super(Idle());

  Future register(
    String name,
    String email,
    String password,
  ) async {
    emit(LoadingRegister());
    try {
      final result = await apiService.register(name, email, password);
      if (result.error == false) {
        emit(SuccessRegister());
      } else {
        emit(FailedRegister(message: result.message));
      }
    } on SocketException catch (e) {
      emit(FailedRegister(message: e.message));
    } catch (e) {
      emit(FailedRegister(message: e.toString()));
    }
  }
}
