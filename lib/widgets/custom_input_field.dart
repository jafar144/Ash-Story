import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final bool hideText;
  final FormFieldValidator<String> validator;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.hideText = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      cursorColor: AppColors.secondaryColor,
      obscureText: hideText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: AppColors.secondaryColor,
        prefixIcon: icon,
        hintText: hintText,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    );
  }
}
