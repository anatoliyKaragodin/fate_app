import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/theme/app_boder_radius.dart';
import '../../../../../core/utils/theme/app_padding.dart';
import '../../../../../core/utils/theme/app_text_styles.dart';
import '../../../domain/entities/mapper/entities_mapper.dart';
import '../common/app_button_widget.dart';
import '../common/app_focus_container_widget.dart';

class AppDiceRollResults extends StatelessWidget {
  const AppDiceRollResults(
      {super.key,
      required this.onTapShowResults,
      required this.height,
      required this.textStyle,
      required this.results,
      required this.padding});

  final VoidCallback onTapShowResults;

  final double height;

  final TextStyle textStyle;

  final List<RollResultEntity> results;

  final double padding;

  @override
  Widget build(BuildContext context) {
    results.sort((a, b) => b.date.compareTo(a.date));

    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: appBorderRadius.big(context)),
      child: Padding(
        padding: EdgeInsets.only(
            left: appPadding.mediumW(context),
            right: appPadding.mediumW(context),
            top: appPadding.mediumH(context)),
        child: Column(
          children: [
            AppButtonWidget(
                textStyle: textStyle,
                text: 'Броски кубов',
                onPressed: () => onTapShowResults()),
            Gap(padding),
            Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              results.length,
                              (index) => _RollResultText(
                                  padding: padding,
                                  result: results[index],
                                  textStyle: textStyle))))),
            )
          ],
        ),
      ),
    );
  }
}

class _RollResultText extends StatelessWidget {
  const _RollResultText({
    required this.padding,
    required this.result,
    required this.textStyle,
  });

  final double padding;
  final RollResultEntity result;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: AppFocusContainerWidget(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('HH:mm:ss').format(result.date),
                style: appTextStyles.textUnfocus(context),
              ),
              Gap(appPadding.smallH(context)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${result.skill.type.toLabel()} подход. ',
                    style: textStyle),
                TextSpan(text: 'Итог: ${result.result}. ', style: textStyle),
                TextSpan(
                    text:
                        '[успехи: ${result.successes}, провалы: ${result.fails}]',
                    style: appTextStyles.textUnfocus(context)),
              ]))
            ],
          )),
    );
  }
}
