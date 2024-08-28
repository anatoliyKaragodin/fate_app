// ignore_for_file: unused_field

import 'package:fate_app/core/utils/app_size.dart';
import 'package:flutter/material.dart';

final appTextStyles = AppTextStyles();

class AppTextStyles {
  static const FontWeight _fontWeightRegular = FontWeight.w400;
  static const FontWeight _fontWeightMedium = FontWeight.w500;
  static const FontWeight _fontWeightSemibold = FontWeight.w600;
  static const FontWeight _fontWeightBold = FontWeight.w700;

  static double _fontSize(BuildContext context, double fontSize) =>
      fontSize.width(context);

  static bool _isDarkMode(BuildContext context) =>
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  static Color _textColor(BuildContext context) =>
      _isDarkMode(context) ? Colors.white70 : Colors.black;

  static Color _buttonTextColor(BuildContext context) => _isDarkMode(context)
      ? Theme.of(context).primaryColorLight
      : Theme.of(context).primaryColorDark;

  // Text styles
  TextStyle title1(BuildContext context) => TextStyle(
      fontWeight: _fontWeightBold,
      fontSize: _fontSize(context, 20),
      color: _textColor(context));

  TextStyle title2(BuildContext context) => TextStyle(
      fontWeight: _fontWeightMedium,
      fontSize: _fontSize(context, 16),
      color: _textColor(context));

  TextStyle text1(BuildContext context) => TextStyle(
      fontWeight: _fontWeightRegular,
      fontSize: _fontSize(context, 14),
      color: _textColor(context));

  TextStyle text2(BuildContext context) => TextStyle(
      fontWeight: _fontWeightRegular,
      fontSize: _fontSize(context, 13),
      color: _textColor(context));

  TextStyle text3(BuildContext context) => TextStyle(
      fontWeight: _fontWeightRegular,
      fontSize: _fontSize(context, 12),
      color: _textColor(context));

  TextStyle button1(BuildContext context) => TextStyle(
      fontWeight: _fontWeightBold,
      fontSize: _fontSize(context, 14),
      color: _buttonTextColor(context));
}
