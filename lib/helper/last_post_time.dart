import 'package:flutter/material.dart';

import '../common/app_localization.dart';

String getLastPostTime(BuildContext context, String datePost) {
  final dateTime = DateTime.parse(datePost);
  final currentDateTime = DateTime.now();
  final difference = currentDateTime.difference(dateTime);

  final durationInMinutes = difference.inMinutes;

  String differenceDuration;
  switch (durationInMinutes) {
    case >= 525600:
      var differenceInYear = durationInMinutes ~/ 525600;
      differenceDuration =
          AppLocalizations.of(context)!.differentDurationYear(differenceInYear);
    case >= 1440:
      differenceDuration = AppLocalizations.of(context)!
          .differentDurationDays(difference.inDays);
    case >= 60:
      differenceDuration = AppLocalizations.of(context)!
          .differentDurationHours(difference.inHours);
    case == 0:
      differenceDuration = AppLocalizations.of(context)!
          .differentDurationSeconds(difference.inSeconds);
    default:
      differenceDuration = AppLocalizations.of(context)!
          .differentDurationMinutes(difference.inMinutes);
  }
  return differenceDuration.toString();
}
