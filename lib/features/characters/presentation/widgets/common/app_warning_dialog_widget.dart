import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_text_styles.dart';
import 'app_button_widget.dart';

/// AppWarningDialogWidget - это виджет, который представляет собой диалоговое окно предупреждения.
///
/// Используется для отображения предупреждений с двумя кнопками для взаимодействия пользователя.

class AppWarningDialogWidget extends StatelessWidget {
  const AppWarningDialogWidget(
      {super.key,
      required this.button1Text,
      required this.button2Text,
      required this.onTapButton1,
      required this.onTapButton2,
      this.text,
      this.title});

  /// Заголовок диалогового окна.
  final String? title;

  /// Текст предупреждения.
  final String? text;

  /// Функция обратного вызова, вызываемая при нажатии на первую кнопку.
  final VoidCallback onTapButton1;

  /// Функция обратного вызова, вызываемая при нажатии на вторую кнопку.
  final VoidCallback onTapButton2;

  /// Текст, отображаемый на первой кнопке.
  final String button1Text;

  /// Текст, отображаемый на второй кнопке.
  final String button2Text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Center(
              child: Text(
              title!,
              style: appTextStyles.title2(context),
            ))
          : null,
      content: text != null
          ? Text(
              text!,
              style: appTextStyles.text1(context),
            )
          : null,
      actions: [
        AppButtonWidget(onPressed: onTapButton1, text: button1Text),
        AppButtonWidget(text: button2Text, onPressed: onTapButton2),
      ],
    );
  }
}
