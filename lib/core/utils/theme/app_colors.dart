import 'package:flutter/material.dart';

final appColors = AppColors();

class AppColors {
  Color buttonColor(BuildContext context) =>
      Theme.of(context).colorScheme.primary.withAlpha(50);

  Color textColor(BuildContext context) =>
      _isDarkMode(context) ? Colors.white70 : Colors.black;

  Color textColorUnfocus(BuildContext context) =>
      _isDarkMode(context) ? Colors.white54 : Colors.black54;

  Color buttonTextColor(BuildContext context) => _isDarkMode(context)
      ? Theme.of(context).primaryColorLight
      : Theme.of(context).primaryColorDark;

  static bool _isDarkMode(BuildContext context) =>
      MediaQuery.of(context).platformBrightness == Brightness.dark;
}
