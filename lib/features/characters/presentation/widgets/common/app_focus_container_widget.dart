import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_boder_radius.dart';
import '../../../../../core/utils/theme/app_padding.dart';

class AppFocusContainerWidget extends StatelessWidget {
  const AppFocusContainerWidget({super.key, required this.child, this.width});

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: appBorderRadius.medium(context),
            color: Theme.of(context).highlightColor.withOpacity(
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? 0.05
                    : 0.2)),
        child: Padding(
          padding: EdgeInsets.all(appPadding.mediumW(context)),
          child: child,
        ));
  }
}
