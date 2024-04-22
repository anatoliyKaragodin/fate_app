import 'package:fate_app/domain/mapper/entities_mapper.dart';
import 'package:fate_app/presentation/pages/character_page/character_page_view_model.dart';
import 'package:fate_app/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:fate_app/presentation/widgets/common/app_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharacterPage extends ConsumerWidget {
  const CharacterPage({super.key, this.character});

  final CharacterEntity? character;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wm = ref.watch(characterPageViewModelProvider);

    void changeName() {
      ref.read(characterPageViewModelProvider.notifier).changeName();
    }

    void saveCharacter() {
      ref.read(characterPageViewModelProvider.notifier).saveCharacter();
    }

    void goBack() {
      ref.read(characterPageViewModelProvider.notifier).goBack(context);
    }

    void saveDescription() {}

    void saveConcept() {}

    void saveProblem() {}

    List<VoidCallback> saveAspectList = List.generate(
        wm.aspectsControllers.length,
        (index) => () {
              ref
                  .read(characterPageViewModelProvider.notifier)
                  .saveAspect(index);
            });

    List<VoidCallback> saveStuntList = List.generate(
        wm.stuntsControllers.length,
        (index) => () {
              ref
                  .read(characterPageViewModelProvider.notifier)
                  .saveStunt(index);
            });

    List<Function(String?)> saveSkillList = List.generate(
        wm.skills.length,
        (index) => (String? value) {
              ref
                  .read(characterPageViewModelProvider.notifier)
                  .saveSkill(index, value);
            });

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: BackButton(
              onPressed: goBack,
            ),
          ),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              controller: wm.nameController,
              hintText: 'Имя',
              onEditingComplete: changeName,
            ),
          ),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              controller: wm.conceptController,
              hintText: 'Концепт',
              onEditingComplete: saveConcept,
            ),
          ),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              controller: wm.problemController,
              hintText: 'Проблема',
              onEditingComplete: saveProblem,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  wm.skills.length,
                  (index) => AppDropdownMenu(
                        label: 'Скилл $index',
                        menuItems: ['', '0', '1', '2', '3'],
                        selectedItem: wm.skills[index]?.toString() ?? '',
                        onItemSelected: (String? value) {
                          saveSkillList[index](value);
                        },
                      )),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: List.generate(
              wm.aspectsControllers.length,
              (index) => AppTextFieldWidget(
                controller: wm.aspectsControllers[index],
                hintText: 'Аспект',
                onEditingComplete: saveAspectList[index],
              ),
            ),
          )),
          SliverToBoxAdapter(
              child: Column(
            children: List.generate(
              wm.stuntsControllers.length,
              (index) => AppTextFieldWidget(
                controller: wm.stuntsControllers[index],
                hintText: 'Трюк',
                onEditingComplete: saveStuntList[index],
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: AppTextFieldWidget(
              controller: wm.descriptionController,
              hintText: 'Описание',
              onEditingComplete: saveDescription,
            ),
          ),
          SliverToBoxAdapter(
            child: AppButtonWidget(
              text: 'Сохранить',
              onPressed: saveCharacter,
            ),
          ),
        ],
      ),
    ));
  }
}
