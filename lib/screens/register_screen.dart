import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/bloc/register/register_cubit.dart';
import 'package:submission_intermediate/bloc/register/register_state.dart';
import 'package:submission_intermediate/common/app_colors.dart';
import 'package:submission_intermediate/common/navigation.dart';
import 'package:submission_intermediate/helper/show_dialog.dart';
import 'package:submission_intermediate/widgets/custom_input_field.dart';
import 'package:submission_intermediate/widgets/my_app_bar.dart';
import 'package:submission_intermediate/widgets/rounded_button.dart';

import '../common/app_localization.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formRegisterKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.register,
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
                  key: _formRegisterKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: _nameController,
                        hintText: AppLocalizations.of(context)!.labelFieldName,
                        icon: const Icon(Icons.person_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.errorFieldName;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomInputField(
                        controller: _emailController,
                        hintText: 'Email',
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
                        hintText: 'Password',
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
                      const SizedBox(height: 15),
                      CustomInputField(
                        controller: _confirmPasswordController,
                        hintText: AppLocalizations.of(context)!
                            .labelFieldConfirmPassword,
                        hideText: true,
                        icon: const Icon(Icons.lock),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .errorFieldConfirmPassword1;
                          } else if (value != _passwordController.text) {
                            return AppLocalizations.of(context)!
                                .errorFieldConfirmPassword2;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                BlocListener<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is SuccessRegister) {
                      showSuccessDialog(
                        context: context,
                        message: AppLocalizations.of(context)!
                            .messageSuccessDialogRegister,
                        onPressed: () {
                          context.goNamed(Navigation.login);
                        },
                      );
                    } else if (state is FailedRegister) {
                      showErrorDialog(
                        context: context,
                        message: state.message,
                        onPressed: () {
                          context.pop();
                        },
                      );
                    }
                  },
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state is LoadingRegister) {
                        return const RoundedButton(
                          onTap: null,
                          useBorder: false,
                          isLoading: true,
                        );
                      }

                      return RoundedButton(
                        text: AppLocalizations.of(context)!.register,
                        useBorder: false,
                        backgroundColor: Colors.white,
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          if (_formRegisterKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(color: AppColors.textSecondary),
                    children: [
                      TextSpan(
                          text:
                              AppLocalizations.of(context)!.alreadyHaveAccount),
                      TextSpan(
                        text: AppLocalizations.of(context)!.login,
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
      AppLocalizations.of(context)!.registerTextSection,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
    );
  }
}
