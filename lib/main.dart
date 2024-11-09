import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_intermediate/bloc/add_story/add_story_cubit.dart';
import 'package:submission_intermediate/bloc/add_story/image_path_cubit.dart';
import 'package:submission_intermediate/bloc/detail/detail_cubit.dart';
import 'package:submission_intermediate/bloc/home/home_cubit.dart';
import 'package:submission_intermediate/bloc/login/login_cubit.dart';
import 'package:submission_intermediate/bloc/logout/logout_cubit.dart';
import 'package:submission_intermediate/bloc/register/register_cubit.dart';
import 'package:submission_intermediate/bloc/splash/splash_cubit.dart';
import 'package:submission_intermediate/common/app_colors.dart';
import 'package:submission_intermediate/common/navigation.dart';
import 'package:submission_intermediate/data/api/api_service.dart';
import 'package:submission_intermediate/data/shared_preferences/preferences_helper.dart';

import 'common/app_localization.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryColor,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesHelper =
        PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
    final apiService = ApiService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(apiService),
        ),
        BlocProvider(
          create: (context) => SplashCubit(preferencesHelper),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            apiService,
            preferencesHelper,
          ),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            apiService,
            preferencesHelper,
          ),
        ),
        BlocProvider(
          create: (context) => DetailCubit(
            apiService,
            preferencesHelper,
          ),
        ),
        BlocProvider(
          create: (context) => ImagePathCubit(),
        ),
        BlocProvider(
          create: (context) => AddStoryCubit(
            apiService,
            preferencesHelper,
          ),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(preferencesHelper),
        ),
      ],
      child: MaterialApp.router(
        title: "Ash Story",
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.primaryColor,
          fontFamily: 'CircularStd',
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: Navigation.router,
      ),
    );
  }
}
