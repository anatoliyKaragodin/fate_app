import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_boder_radius.dart';
import '../../../../../core/utils/theme/app_padding.dart';

class AppFocusContainerWidget extends StatelessWidget {
  const AppFocusContainerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: appBorderRadius.medium(context),
            color: Theme.of(context).highlightColor.withOpacity(
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? 0.03
                    : 0.2)),
        child: Padding(
          padding: EdgeInsets.all(appPadding.mediumW(context)),
          child: child,
        ));
  }
}
