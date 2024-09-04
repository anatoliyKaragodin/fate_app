import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_colors.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';

import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_character_avatar_widget.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'app_icon_button.dart';

/// AppCharacterSmallContainer - это виджет, который отображает информацию о персонаже
/// в компактном формате, включая имя, аватар, концепцию и навыки.

class AppCharacterSmallContainer extends StatelessWidget {
  const AppCharacterSmallContainer(
      {super.key,
      required this.character,
      required this.onTapEdit,
      required this.onTapDelete,
      required this.onTap});

  /// Объект персонажа, содержащий информацию для отображения.
  final CharacterEntity character;

  /// Функция, которая будет вызываться при нажатии на контейнер.
  final VoidCallback onTap;

  /// Функция, которая будет вызываться при нажатии на кнопку редактирования.
  final VoidCallback onTapEdit;

  /// Функция, которая будет вызываться при нажатии на кнопку удаления.
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appColors.buttonColor(context),
          borderRadius: appBorderRadius.medium(context),
        ),
        child: Padding(
          padding: EdgeInsets.all(appPadding.bigW(context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (character.createdAt != null)
                    Text(
                      'Cоздан: ${DateFormat('yyyy-MM-dd HH:mm').format(character.createdAt!)}',
                      style: appTextStyles.textUnfocus(context),
                    ),
                  if (character.createdAt != null &&
                      character.updatedAt != null &&
                      character.updatedAt!
                              .difference(character.createdAt!)
                              .inSeconds >
                          1)
                    Text(
                      'Обновлен: ${DateFormat('yyyy-MM-dd HH:mm').format(character.updatedAt!)}',
                      style: appTextStyles.textUnfocus(context),
                    )
                ],
              ),
              Text(character.name, style: appTextStyles.title1(context)),
              Gap(8.height(context)),
              if (character.image != null)
                AppCharacterAvatarWidget(
                    imagePath: character.image!,
                    height: 100.height(context),
                    width: 100.width(context)),
              Gap(appPadding.mediumH(context)),
              Text(
                character.concept,
                style: appTextStyles.title2(context),
              ),
              Gap(appPadding.mediumH(context)),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100.width(context),
                    child: Column(
                      children: List.generate(character.skills.length, (index) {
                        final skill = character.skills[index];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skill.type.toLabel(),
                              style: appTextStyles.text3(context),
                            ),
                            Text(
                              skill.value.toString(),
                              style: appTextStyles.text3(context),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  Column(
                    children: [
                      AppIconButton(
                          onTap: onTapDelete, icon: Icons.delete_forever),
                      AppIconButton(onTap: onTapEdit, icon: Icons.edit),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
