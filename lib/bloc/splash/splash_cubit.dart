import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/splash/splash_state.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

class SplashCubit extends Cubit<SplashState> {
  final PreferencesHelper preferencesHelper;

  SplashCubit(this.preferencesHelper) : super(DisplaySplash()) {
    appStarted();
  }

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLoggedIn = await preferencesHelper.getTokenLogin();
    if (isLoggedIn != null) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
