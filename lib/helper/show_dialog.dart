import 'package:flutter/material.dart';

import '../common/app_localization.dart';

void showSuccessDialog({
  required BuildContext context,
  required VoidCallback onPressed,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.success,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showErrorDialog({
  required BuildContext context,
  required VoidCallback onPressed,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.failed,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
