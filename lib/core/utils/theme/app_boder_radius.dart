import 'package:fate_app/core/utils/app_size.dart';
import 'package:flutter/material.dart';

final appBorderRadius = AppBorderRadius();

class AppBorderRadius {
// Бордер радиусы

  BorderRadius small(BuildContext context) =>
      BorderRadius.circular(8.width(context));

  BorderRadius medium(BuildContext context) =>
      BorderRadius.circular(16.width(context));

  BorderRadius big(BuildContext context) =>
      BorderRadius.circular(32.width(context));

// Радиусы

  Radius smallRadius(BuildContext context) => Radius.circular(8.width(context));

  Radius mediumRadius(BuildContext context) =>
      Radius.circular(16.width(context));
}
