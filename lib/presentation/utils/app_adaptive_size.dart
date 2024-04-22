import 'package:flutter/material.dart';

class AppAdaptiveSize {
  final BuildContext context;

  const AppAdaptiveSize(this.context);

  static const _figmaHeight = 812;

  static const _figmaWidth = 375;

  get height => MediaQuery.of(context).size.longestSide;

  get width => MediaQuery.of(context).size.shortestSide;

  double heightInPixels(double value) => value * (height / _figmaHeight);

  double widthInPixels(double value) => value * (width / _figmaWidth);
}
