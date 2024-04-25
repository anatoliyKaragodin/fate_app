import 'package:fate_app/presentation/utils/app_adaptive_size.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = AppAdaptiveSize(context);

    return UnconstrainedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 0),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.heightInPixels(8)),
          child: Text(text),
        ),
      ),
    );
  }
}
