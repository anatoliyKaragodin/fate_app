import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_boder_radius.dart';

/// AppBottomSheet - это виджет, который отображает текст в виде нижнего листа (bottom sheet).
///
/// Этот виджет используется для отображения информации или действий в виде
/// всплывающего окна в нижней части экрана.

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, required this.text});

  /// Текст, который будет отображаться в нижнем листе.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: appBorderRadius.medium(context)),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(appPadding.mediumW(context)),
        child: Center(child: Text(text)),
      ),
    );
  }
}
