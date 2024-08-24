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

  // Text styles
  TextStyle title1(BuildContext context) => TextStyle(
        fontWeight: _fontWeightBold,
        fontSize: _fontSize(context, 20),
      );

  TextStyle title2(BuildContext context) => TextStyle(
        fontWeight: _fontWeightMedium,
        fontSize: _fontSize(context, 16),
      );

  TextStyle text1(BuildContext context) => TextStyle(
        fontWeight: _fontWeightRegular,
        fontSize: _fontSize(context, 14),
      );

  TextStyle text2(BuildContext context) => TextStyle(
        fontWeight: _fontWeightRegular,
        fontSize: _fontSize(context, 13),
      );

  TextStyle text3(BuildContext context) => TextStyle(
        fontWeight: _fontWeightRegular,
        fontSize: _fontSize(context, 12),
      );

  TextStyle button1(BuildContext context) => TextStyle(
        fontWeight: _fontWeightBold,
        fontSize: _fontSize(context, 14),
      );
}
