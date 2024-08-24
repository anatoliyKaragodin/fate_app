import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_icon_button.dart';

import 'package:flutter/material.dart';


/// AppTextFieldWidget - это виджет, который представляет собой текстовое поле

/// для ввода данных с дополнительными функциями, такими как подсказка и кнопка помощи.

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onEditing,
      this.maxLength,
      this.width,
      this.onTapHelp});

  /// Контроллер для управления текстом в поле ввода.

  final TextEditingController controller;

  /// Текст-подсказка, отображаемый в поле ввода.

  final String hintText;

  /// Ширина текстового поля (по умолчанию - null).

  final double? width;

  /// Функция, вызываемая при изменении текста.

  final Function(String)? onEditing;

  /// Максимальная длина текста, который можно ввести (по умолчанию - null).

  final int? maxLength;

  /// Функция, вызываемая при нажатии на кнопку помощи (по умолчанию - null).

  final VoidCallback? onTapHelp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Column(
          children: [
            if (onTapHelp != null) AppIconButton(onTap: onTapHelp ?? () {}),
            TextField(
              style: appTextStyles.text1(context),
              textCapitalization: TextCapitalization.sentences,
              maxLength: maxLength,
              maxLines: null,
              minLines: 1,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: appBorderRadius.medium(context)),
                labelText: hintText,
              ),
              onChanged: (value) =>
                  onEditing != null ? onEditing!(value) : null,
            ),
          ],
        ));
  }
}
