import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_padding.dart';

/// AppIconButton - это виджет, который представляет собой кнопку с иконкой.

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, required this.onTap, this.icon});

  /// Функция обратного вызова, которая будет вызвана при нажатии на кнопку.
  final VoidCallback onTap;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(appPadding.smallW(context)),
      child: SizedBox(
          width: 20.width(context) + appPadding.mediumW(context),
          height: 20.width(context) + appPadding.mediumW(context),
          child: Center(
            child: IconButton(
              color: appColors.buttonTextColor(context),
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                iconSize: 20.width(context),
                onPressed: onTap,
                icon: Icon(icon ?? Icons.help)),
          )),
    );
  }
}
