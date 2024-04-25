import 'package:fate_app/domain/mapper/entities_mapper.dart';
import 'package:fate_app/presentation/utils/app_adaptive_size.dart';
import 'package:flutter/material.dart';

class AppCharacterSmallContainer extends StatelessWidget {
  const AppCharacterSmallContainer({super.key, required this.character});
  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final size = AppAdaptiveSize(context);

    return Padding(
      padding: EdgeInsets.all(size.widthInPixels(16)),
      child: Container(
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
          borderRadius: BorderRadius.circular(size.widthInPixels(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.widthInPixels(8)),
          child: Column(
            children: [
              Text(character.name),
              Text(character.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    character.skills.length,
                    (index) => Column(
                          children: [
                            Text('скилл$index'),
                            Text(character.skills[index].toString())
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
