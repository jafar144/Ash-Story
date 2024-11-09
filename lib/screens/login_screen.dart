import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/bloc/login/login_cubit.dart';
import 'package:submission_intermediate/bloc/login/login_state.dart';
import 'package:submission_intermediate/common/app_colors.dart';
import 'package:submission_intermediate/common/navigation.dart';
import 'package:submission_intermediate/widgets/custom_input_field.dart';
import 'package:submission_intermediate/widgets/rounded_button.dart';

import '../common/app_localization.dart';
import '../helper/show_dialog.dart';
import '../widgets/my_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formLoginKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.login,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                introTextSection(),
                const SizedBox(height: 40),
                Form(
                  key: _formLoginKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: _emailController,
                        hintText: "Email",
                        icon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .errorFieldEmail1;
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return AppLocalizations.of(context)!
                                .errorFieldEmail2;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomInputField(
                        controller: _passwordController,
                        hintText: "Password",
                        hideText: true,
                        icon: const Icon(Icons.lock),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .errorFieldPassword1;
                          } else if (value.length < 8) {
                            return AppLocalizations.of(context)!
                                .errorFieldPassword2;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is SuccessLogin) {
                      context.goNamed(Navigation.home);
                    } else if (state is FailedLogin) {
                      debugPrint(state.message);
                      showErrorDialog(
                        context: context,
                        message: state.message,
                        onPressed: () {
                          context.pop();
                        },
                      );
                    }
                  },
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoadingLogin) {
                        return const RoundedButton(
                          onTap: null,
                          useBorder: false,
                          isLoading: true,
                        );
                      }

                      return RoundedButton(
                        text: AppLocalizations.of(context)!.login,
                        useBorder: false,
                        backgroundColor: Colors.white,
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          if (_formLoginKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(color: AppColors.textSecondary),
                    children: [
                      TextSpan(text: AppLocalizations.of(context)!.haveAccount),
                      TextSpan(
                        text: AppLocalizations.of(context)!.registerHere,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.goNamed(Navigation.login);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text introTextSection() {
    return Text(
      AppLocalizations.of(context)!.loginTextSection,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
    );
  }
}
