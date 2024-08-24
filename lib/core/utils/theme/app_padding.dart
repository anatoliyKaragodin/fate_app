import 'package:fate_app/core/utils/app_size.dart';
import 'package:flutter/material.dart';

final appPadding = AppPadding();

class AppPadding {
  double smallH(BuildContext context) => 4.height(context);

  double smallW(BuildContext context) => 4.width(context);

  double mediumH(BuildContext context) => 8.height(context);

  double mediumW(BuildContext context) => 8.height(context);

  double bigH(BuildContext context) => 16.height(context);

  double bigW(BuildContext context) => 16.height(context);
}
