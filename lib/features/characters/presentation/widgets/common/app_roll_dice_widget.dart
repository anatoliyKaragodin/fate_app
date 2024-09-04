import 'package:fate_app/core/utils/theme/app_boder_radius.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import '../../../domain/entities/mapper/entities_mapper.dart';

class AppRollDiceWidget extends StatefulWidget {
  const AppRollDiceWidget(
      {super.key,
      required this.skill,
      required this.onRoll,
      required this.onCancel});

  final SkillEntity skill;
  final Function(int value) onRoll;
  final VoidCallback onCancel;

  @override
  State<AppRollDiceWidget> createState() => _AppRollDiceWidgetState();
}

class _AppRollDiceWidgetState extends State<AppRollDiceWidget> {
  int currentPlus = 0;
  int currentMinus = 0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: appPadding.mediumW(context),
            vertical: appPadding.mediumH(context)),
        title: Center(
          child: Column(
            children: [
              Text(
                'Бросить ${widget.skill.type.toLabel().toLowerCase()} подход?',
                style: appTextStyles.text1(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppDropdownMenu<int>(
                      label: '${widget.skill.value} +  ',
                      menuItems: List.generate(11, (i) => i),
                      selectedItem: currentPlus,
                      onItemSelected: (value) {
                        if (value != null) {
                          setState(() {
                            currentPlus = value;
                            dev.log(currentPlus.toString());
                          });
                        }
                      }),
                  AppDropdownMenu<int>(
                      label: ' -  ',
                      menuItems: List.generate(11, (i) => i),
                      selectedItem: currentMinus,
                      onItemSelected: (value) {
                        if (value != null) {
                          setState(() {
                            currentMinus = value;
                            dev.log(currentMinus.toString());
                          });
                        }
                      })
                ],
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: appBorderRadius.medium(context)),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding.bigW(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtonWidget(
                    text: 'Отмена', onPressed: () => widget.onCancel()),
                AppButtonWidget(
                    text: 'Да',
                    onPressed: () => widget.onRoll(
                        widget.skill.value! + currentPlus - currentMinus))
              ],
            ),
          ),
        ]);
  }
}
