import 'package:fate_app/domain/mapper/entities_mapper.dart';
import 'package:fate_app/presentation/pages/character_page/character_page_view_model.dart';
import 'package:fate_app/presentation/utils/app_adaptive_size.dart';
import 'package:fate_app/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:fate_app/presentation/widgets/common/app_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CharacterPage extends ConsumerWidget {
  const CharacterPage({super.key, this.character});

  final CharacterEntity? character;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wmProvider = ref.watch(characterPageViewModelProvider);

    final size = AppAdaptiveSize(context);

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: BackButton(
              onPressed: () => ref
                  .read(characterPageViewModelProvider.notifier)
                  .goBack(context),
            ),
          ),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              hintText: 'Имя',
              onEditing:
                  ref.read(characterPageViewModelProvider.notifier).saveName,
            ),
          ),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              hintText: 'Концепт',
              onEditing:
                  ref.read(characterPageViewModelProvider.notifier).saveConcept,
            ),
          ),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              hintText: 'Проблема',
              onEditing:
                  ref.read(characterPageViewModelProvider.notifier).saveProblem,
            ),
          ),
          SliverToBoxAdapter(child: Gap(size.heightInPixels(20))),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  wmProvider.skills.length,
                  (index) => AppDropdownMenu(
                        label: 'Скилл $index',
                        menuItems: ['', '0', '1', '2', '3'],
                        selectedItem: wmProvider.skills[index] == -1
                            ? ''
                            : wmProvider.skills[index].toString(),
                        onItemSelected: (String? value) {
                          ref
                              .read(characterPageViewModelProvider.notifier)
                              .saveSkill(index, value);
                        },
                      )),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: List.generate(
              3,
              (index) => AppTextFieldWidget(
                hintText: 'Аспект',
                onEditing: (value) => ref
                    .read(characterPageViewModelProvider.notifier)
                    .saveAspect(index, value),
              ),
            ),
          )),
          SliverToBoxAdapter(
              child: Column(
            children: List.generate(
              3,
              (index) => AppTextFieldWidget(
                hintText: 'Трюк',
                onEditing: (value) => ref
                    .read(characterPageViewModelProvider.notifier)
                    .saveStunt(index, value),
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              hintText: 'Описание',
              onEditing: ref
                  .read(characterPageViewModelProvider.notifier)
                  .saveDescription,
            ),
          ),
          SliverToBoxAdapter(child: Gap(size.heightInPixels(20))),
          SliverToBoxAdapter(
            child: AppButtonWidget(
              text: 'Сохранить',
              onPressed: () => ref
                  .read(characterPageViewModelProvider.notifier)
                  .saveCharacter(),
            ),
          ),
          SliverToBoxAdapter(child: Gap(size.heightInPixels(20))),
        ],
      ),
    ));
  }
}
