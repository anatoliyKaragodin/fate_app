import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/mapper/entities_mapper.dart';

/// AppDropdownMenu - это виджет, который представляет собой выпадающее меню
/// для выбора элемента из списка.
class AppDropdownMenu<T> extends StatelessWidget {
  /// Метка, отображаемая рядом с выпадающим меню.

  final String label;

  /// Список элементов, доступных для выбора.

  final List<T?> menuItems;

  /// Текущий выбранный элемент.

  final T? selectedItem;

  /// Функция, вызываемая при выборе нового элемента.

  final Function(T?) onItemSelected;

  /// Ширина выпадающего меню (по умолчанию - null).

  final double? width;

  /// Высота выпадающего меню (по умолчанию - null).

  final double? height;

  /// Фиксированная ширина только у выпадающего списка; подпись идёт сразу слева от
  /// него, свободное место в строке — в [Spacer] (удобно в [AppBar]).
  final double? dropdownTrailingWidth;

  const AppDropdownMenu(
      {super.key,
      required this.label,
      required this.menuItems,
      required this.selectedItem,
      required this.onItemSelected,
      this.width,
      this.height,
      this.dropdownTrailingWidth});

  @override
  Widget build(BuildContext context) {
    final items = menuItems.map<DropdownMenuItem<T?>>((T? value) {
      return DropdownMenuItem<T?>(
        value: value,
        child: Text(
          value is StuntType
              ? (value as StuntType).toLabel()
              : (value != null ? value.toString() : 'нет'),
          overflow: TextOverflow.ellipsis,
          style: appTextStyles.text1(context),
        ),
      );
    }).toList();

    final dropdown = DropdownButton<T?>(
      borderRadius: appBorderRadius.medium(context),
      itemHeight: 48.0,
      // В Row без фиксированной ширины (напр. диалог броска кубов) maxWidth = ∞ —
      // isExpanded + Expanded даёт assert «unbounded constraints».
      isExpanded: width != null || dropdownTrailingWidth != null,
      underline: const SizedBox.shrink(),
      value: selectedItem,
      onChanged: (T? newValue) {
        onItemSelected(newValue);
      },
      items: items,
    );

    final labelText = Text(
      label,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: appTextStyles.text1(context),
    );

    final row = dropdownTrailingWidth != null
        ? Row(
            children: [
              // flex по умолчанию у Flexible = 1, тогда подпись и Spacer делят строку
              // пополам и текст режется раньше времени. flex: 0 — только intrinsic ширина.
              Flexible(
                flex: 0,
                fit: FlexFit.loose,
                child: labelText,
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: dropdownTrailingWidth,
                child: dropdown,
              ),
              const Spacer(),
            ],
          )
        : width != null
            ? Row(
                children: [
                  Expanded(child: labelText),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: dropdown,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: labelText,
                  ),
                  const SizedBox(width: 8),
                  dropdown,
                ],
              );

    return SizedBox(
      height: height,
      width: dropdownTrailingWidth != null ? null : width,
      child: row,
    );
  }
}
