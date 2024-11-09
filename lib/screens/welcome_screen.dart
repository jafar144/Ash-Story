import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/common/app_colors.dart';
import 'package:submission_intermediate/common/app_localization.dart';
import 'package:submission_intermediate/common/navigation.dart';
import 'package:submission_intermediate/widgets/rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  imageSection(),
                  const SizedBox(height: 30),
                  titleSection(),
                  const SizedBox(height: 30),
                  descriptionSection(),
                ],
              ),
              loginRegisterSection(context),
            ],
          ),
        ),
      ),
    );
  }

  SvgPicture imageSection() {
    return SvgPicture.asset(
      'assets/vectors/welcome.svg',
      height: 200,
      width: double.infinity,
    );
  }

  Text titleSection() {
    return const Text(
      'Social Chatter Team.',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Padding descriptionSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Lorem Ipsum is Simply term that if we use it, we could die anjasy. Watasi kimamoto anajsjs udes',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: AppColors.textSecondary,
          height: 2,
        ),
      ),
    );
  }

  Widget loginRegisterSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RoundedButton(
            text: AppLocalizations.of(context)!.login,
            textColor: AppColors.primaryColor,
            backgroundColor: Colors.white,
            useBorder: false,
            onTap: () {
              context.goNamed(Navigation.login);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: RoundedButton(
            text: AppLocalizations.of(context)!.register,
            useBorder: true,
            borderColor: Colors.white,
            onTap: () {
              context.goNamed(Navigation.register);
            },
          ),
        ),
      ],
    );
  }
}
