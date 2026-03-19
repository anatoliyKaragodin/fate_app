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

  const AppDropdownMenu(
      {super.key,
      required this.label,
      required this.menuItems,
      required this.selectedItem,
      required this.onItemSelected,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: appTextStyles.text1(context),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<T?>(
                borderRadius: appBorderRadius.medium(context),
                itemHeight: 48.0,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                value: selectedItem,
                onChanged: (T? newValue) {
                  onItemSelected(newValue);
                },
                items: menuItems.map<DropdownMenuItem<T?>>((T? value) {
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
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
