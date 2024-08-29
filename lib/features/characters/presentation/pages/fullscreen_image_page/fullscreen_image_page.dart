import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/router/router.dart';

class FullscreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullscreenImagePage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          RouterHelper.router.pop();
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Hero(
            tag: imagePath,
            child: Image.file(File(imagePath)),
          ),
        ),
      ),
    );
  }
}
