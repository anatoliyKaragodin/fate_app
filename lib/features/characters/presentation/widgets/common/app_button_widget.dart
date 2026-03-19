import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_colors.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';

import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {super.key, required this.text, required this.onPressed, this.textStyle});

  /// Текст, который будет отображаться на кнопке.
  final String text;

  /// Функция, которая будет вызываться при нажатии на кнопку.
  final VoidCallback onPressed;

  /// Стиль текста
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: appColors.buttonColor(context),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          shape: RoundedRectangleBorder(
              borderRadius: appBorderRadius.medium(context))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: appPadding.bigW(context),
            vertical: appPadding.mediumH(context)),
        child: Text(
          text,
          style: textStyle ?? appTextStyles.button1(context),
        ),
      ),
    );
  }
}
