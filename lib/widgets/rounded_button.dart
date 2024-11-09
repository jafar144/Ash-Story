import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final double? height;
  final String? text;
  final GestureTapCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool useBorder;
  final Color? borderColor;
  final bool isLoading;

  const RoundedButton({
    super.key,
    this.height,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    required this.useBorder,
    this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          border: useBorder
              ? Border.all(
                  color: borderColor!,
                  width: 0.5,
                )
              : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
