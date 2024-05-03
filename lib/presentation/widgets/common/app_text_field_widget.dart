import 'package:fate_app/presentation/utils/app_adaptive_size.dart';
import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatefulWidget {
  const AppTextFieldWidget({
    super.key,
    // required this.controller,
    required this.hintText,
    required this.onEditing,
  });

  // final TextEditingController controller;
  final String hintText;
  final Function(String) onEditing;

  @override
  State<AppTextFieldWidget> createState() => _AppTextFieldWidgetState();
}

class _AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppAdaptiveSize(context).widthInPixels(16)),
        child: Container(
            child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: widget.hintText,
              ),
              onChanged: (value)=>widget.onEditing(value),
              // onEditingComplete: widget.onEditingComplete(textController.text),
            )
          ],
        )));
  }
}
