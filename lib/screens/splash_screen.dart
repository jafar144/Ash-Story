import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/bloc/splash/splash_cubit.dart';
import 'package:submission_intermediate/bloc/splash/splash_state.dart';
import 'package:submission_intermediate/common/app_colors.dart';
import 'package:submission_intermediate/common/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          context.goNamed(Navigation.welcome);
        } else if (state is Authenticated) {
          context.goNamed(Navigation.home);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Image.asset(
            'assets/images/logo_app.png',
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
