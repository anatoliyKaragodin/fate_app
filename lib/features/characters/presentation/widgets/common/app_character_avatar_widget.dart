import 'dart:io';

import 'package:fate_app/features/characters/presentation/utils/app_size.dart';

import 'package:flutter/material.dart';

/// AppCharacterAvatarWidget - это виджет, который отображает аватар персонажа
/// в виде изображения с заданными размерами и скругленными углами.

class AppCharacterAvatarWidget extends StatelessWidget {
  const AppCharacterAvatarWidget(
      {super.key,
      required this.imagePath,
      required this.height,
      required this.width,
      this.borderRadius = 16});

  /// Путь к изображению персонажа на устройстве.
  final String imagePath;

  /// Высота аватара.
  final double height;

  /// Ширина аватара.
  final double width;

  /// Радиус скругления углов аватара.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(
              File(imagePath),
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(borderRadius.width(context)),
        ),
      ),
    );
  }
}
