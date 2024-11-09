import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/bloc/logout/logout_cubit.dart';
import 'package:submission_intermediate/bloc/logout/logout_state.dart';
import 'package:submission_intermediate/common/navigation.dart';

import '../common/app_colors.dart';
import '../common/app_localization.dart';
import '../widgets/rounded_button.dart';

void showCustomBottomSheet(
  BuildContext context,
  VoidCallback logout,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 220,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Logout?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: logoutCancelSection(context, logout),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget logoutCancelSection(
  BuildContext context,
  VoidCallback onTap,
) {
  return BlocConsumer<LogoutCubit, LogoutState>(
    listener: (context, state) {
      if (state is Success) {
        context.goNamed(Navigation.welcome);
      }
    },
    builder: (context, state) {
      if (state is Loading) {
        return Row(
          children: [
            const Expanded(
              child: RoundedButton(
                text: 'Logout',
                textColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                useBorder: true,
                borderColor: AppColors.primaryColor,
                onTap: null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RoundedButton(
                text: AppLocalizations.of(context)!.cancel,
                useBorder: false,
                onTap: null,
              ),
            ),
          ],
        );
      }

      return Row(
        children: [
          Expanded(
            child: RoundedButton(
              text: 'Logout',
              textColor: AppColors.primaryColor,
              backgroundColor: Colors.white,
              useBorder: true,
              borderColor: AppColors.primaryColor,
              onTap: onTap,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RoundedButton(
              text: AppLocalizations.of(context)!.cancel,
              useBorder: false,
              onTap: () {
                context.pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
