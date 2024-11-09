import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/detail/detail_state.dart';
import 'package:submission_intermediate/data/api/api_service.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

class DetailCubit extends Cubit<DetailState> {
  final ApiService apiService;
  final PreferencesHelper preferencesHelper;

  DetailCubit(
    this.apiService,
    this.preferencesHelper,
  ) : super(Loading());

  void initDataDetail(String id) async {
    emit(Loading());
    try {
      final token = await preferencesHelper.getTokenLogin();
      final result = await apiService.getDetailResponse(id, token);
      if (result.error == false) {
        emit(Success(story: result.story));
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
