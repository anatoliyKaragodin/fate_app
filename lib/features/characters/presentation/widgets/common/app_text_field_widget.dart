import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_colors.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';

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
      this.onTapHelp,
      this.onTapRegenerateAi,
      this.textStyle});

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

  /// Перегенерация поля с ИИ — кнопка рядом с помощью (если задана).
  final VoidCallback? onTapRegenerateAi;

  /// Стиль текста

  final TextStyle? textStyle;

  static const double _suffixTap = 44;

  @override
  Widget build(BuildContext context) {
    final iconColor = appColors.textColor(context);
    final hasSuffix = onTapHelp != null || onTapRegenerateAi != null;

    var suffixMinWidth = 0.0;
    if (onTapHelp != null) suffixMinWidth += _suffixTap;
    if (onTapRegenerateAi != null) suffixMinWidth += _suffixTap;

    return SizedBox(
        width: width,
        child: TextField(
          style: textStyle ?? appTextStyles.text1(context),
          textCapitalization: TextCapitalization.sentences,
          maxLength: maxLength,
          maxLines: null,
          minLines: 1,
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: appBorderRadius.medium(context)),
              enabledBorder: OutlineInputBorder(
                borderRadius: appBorderRadius.medium(context),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: appBorderRadius.medium(context),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              labelText: hintText,
              labelStyle: textStyle ?? appTextStyles.text1(context),
              suffixIcon: hasSuffix
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (onTapHelp != null)
                          IconButton(
                            onPressed: onTapHelp,
                            icon: Icon(Icons.help_outline, color: iconColor),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: _suffixTap,
                              minHeight: _suffixTap,
                            ),
                            tooltip: 'Справка',
                          ),
                        if (onTapRegenerateAi != null)
                          Tooltip(
                            message: 'Перегенерировать с ИИ',
                            child: IconButton(
                              onPressed: onTapRegenerateAi,
                              icon: Icon(Icons.auto_awesome_outlined,
                                  color: iconColor),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: _suffixTap,
                                minHeight: _suffixTap,
                              ),
                            ),
                          ),
                      ],
                    )
                  : null,
              suffixIconConstraints: hasSuffix
                  ? BoxConstraints(
                      minHeight: _suffixTap,
                      minWidth: suffixMinWidth,
                    )
                  : null),
          onChanged: (value) =>
              onEditing != null ? onEditing!(value) : null,
        ));
  }
}
