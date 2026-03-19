import 'package:flutter/material.dart';

class AppSize {
  AppSize._();
  static const figmaHeight = 812;
  static const figmaWidth = 375;

  static double height(
    double value,
    BuildContext context,
  ) {
    double height = MediaQuery.of(context).size.longestSide;
    return value * (height / figmaHeight);
  }

  static double width(
    double value,
    BuildContext context,
  ) {
    double width = MediaQuery.of(context).size.shortestSide;
    return value * (width / figmaWidth);
  }
}

extension SizeIntExtention on int {
  double height(BuildContext context) {
    return AppSize.height(toDouble(), context);
  }

  double width(BuildContext context) {
    return AppSize.width(toDouble(), context);
  }
}

extension SizeDoubleExtention on double {
  double height(BuildContext context) {
    return AppSize.height(this, context);
  }

  double width(BuildContext context) {
    return AppSize.width(this, context);
  }
}
