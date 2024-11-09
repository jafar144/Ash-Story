import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/logout/logout_state.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final PreferencesHelper preferencesHelper;

  LogoutCubit(this.preferencesHelper) : super(Init());

  Future logout() async {
    emit(Loading());
    try {
      await preferencesHelper.removeTokenLogin();
      emit(Success());
    } catch (e) {
      emit(Failed(message: 'Failed to Logout'));
    }
  }
}
