import 'package:fate_app/features/characters/domain/mapper/entities_mapper.dart';

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
      required this.onTap,
      required this.onTapDelete});

  /// Объект персонажа, содержащий информацию для отображения.
  final CharacterEntity character;

  /// Функция, которая будет вызываться при нажатии на контейнер.
  final VoidCallback onTap;

  /// Функция, которая будет вызываться при нажатии на кнопку удаления.
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.width(context)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16.width(context)),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.width(context)),
            child: Column(
              children: [
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.headlineSmall),
                
                Gap(8.height(context)),
                if (character.image != null)
                  AppCharacterAvatarWidget(
                      imagePath: character.image!,
                      height: 100.height(context),
                      width: 100.width(context)),
                Gap(8.height(context)),
                Text(character.concept, style: Theme.of(context).textTheme.bodyLarge,),
                Gap(8.height(context)),
                SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100.width(context),
                      child: Column(
                        children:
                            List.generate(character.skills.length, (index) {
                          final skill = character.skills[index];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                skill.type.toLabel(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                skill.value.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    IconButton(
                        onPressed: onTapDelete,
                        icon: const Icon(Icons.delete_forever))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
