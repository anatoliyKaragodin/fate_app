import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';

import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_character_avatar_widget.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

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
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: appBorderRadius.medium(context),
        ),
        child: Padding(
          padding: EdgeInsets.all(appPadding.bigW(context)),
          child: Column(
            children: [
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
                      IconButton(
                          onPressed: onTapDelete,
                          icon: const Icon(Icons.delete_forever)),
                      IconButton(
                          onPressed: onTapEdit, icon: const Icon(Icons.edit)),
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
