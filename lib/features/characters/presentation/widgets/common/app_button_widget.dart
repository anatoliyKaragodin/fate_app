import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';

import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {super.key, required this.text, required this.onPressed});

  /// Текст, который будет отображаться на кнопке.
  final String text;

  /// Функция, которая будет вызываться при нажатии на кнопку.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: ElevatedButton(
        
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: appBorderRadius.medium(context)
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(appPadding.mediumW(context)),
          child: Text(text, style: appTextStyles.button1(context),),
        ),
      ),
    );
  }
}
