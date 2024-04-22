import 'package:fate_app/presentation/utils/app_adaptive_size.dart';
import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppAdaptiveSize(context).widthInPixels(16)),
        child: Container(
            child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: hintText,
              ),
              onEditingComplete: onEditingComplete,
            )
          ],
        )));
  }
}
