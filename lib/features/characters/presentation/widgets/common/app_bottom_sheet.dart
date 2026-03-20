import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:flutter/material.dart';

/// AppBottomSheet - это виджет, который отображает текст в виде нижнего листа (bottom sheet).
///
/// Ручку перетаскивания задайте через [showModalBottomSheet] (`showDragHandle: true`).
/// Нижний отступ учитывает safe area.

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, required this.text});

  /// Текст, который будет отображаться в нижнем листе.
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.65,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          appPadding.mediumW(context),
          appPadding.smallW(context),
          appPadding.mediumW(context),
          appPadding.mediumW(context),
        ),
        child: SingleChildScrollView(
          child: SelectableText(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
