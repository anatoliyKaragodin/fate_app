import 'package:fate_app/features/characters/presentation/utils/app_size.dart';

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
        ),
        child: Padding(
          padding: EdgeInsets.all(8.height(context)),
          child: Text(text),
        ),
      ),
    );
  }
}
