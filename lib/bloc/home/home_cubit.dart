import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/home/home_state.dart';
import 'package:submission_intermediate/data/api/api_service.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;
  final PreferencesHelper preferencesHelper;

  HomeCubit(
    this.apiService,
    this.preferencesHelper,
  ) : super(Loading());

  void initDataHome() async {
    try {
      final token = await preferencesHelper.getTokenLogin();
      final result = await apiService.getAllStory(token);
      if (result.error == false) {
        emit(Success(listStory: result.listStory));
      } else {
        emit(Error(error: result.message));
      }
    } on SocketException catch (e) {
      emit(Error(error: e.message));
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}
