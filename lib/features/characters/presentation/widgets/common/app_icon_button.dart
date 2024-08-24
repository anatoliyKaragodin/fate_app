import 'package:fate_app/core/utils/app_size.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_padding.dart';

/// AppIconButton - это виджет, который представляет собой кнопку с иконкой.

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, required this.onTap});

  /// Функция обратного вызова, которая будет вызвана при нажатии на кнопку.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(appPadding.smallW(context)),
      child: SizedBox(
          width: 18.width(context) + appPadding.mediumW(context),
          height: 18.width(context) + appPadding.mediumW(context),
          child: Center(
            child: IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                iconSize: 18.width(context),
                onPressed: onTap,
                icon: const Icon(Icons.help)),
          )),
    );
  }
}