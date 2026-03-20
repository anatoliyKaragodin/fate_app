import 'package:fate_app/core/router/router.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/presentation/pages/ai_settings_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class AiSettingsPage extends ConsumerWidget {
  const AiSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiSettingsPageViewModelProvider);
    final notifier = ref.read(aiSettingsPageViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ИИ: настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => RouterHelper.router.go(RouterHelper.allCharactersPath),
        ),
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(appPadding.bigW(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Выбор сервиса ИИ для генерации персонажа.',
                    style: appTextStyles.text1(context),
                  ),
                  Gap(appPadding.smallH(context)),
                  Text(
                    'У Groq в ряде регионов или сетей может понадобиться VPN.',
                    style: appTextStyles.text2(context),
                  ),
                  Gap(appPadding.bigH(context)),
                  DropdownButtonFormField<AiProvider>(
                    value: state.selectedProvider,
                    items: [
                      for (final p in AiProvider.values)
                        DropdownMenuItem(
                          value: p,
                          child: Text(p.displayLabel),
                        ),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      notifier.setProvider(v);
                    },
                  ),
                  Gap(appPadding.bigH(context)),
                  AppButtonWidget(
                    text: 'Сохранить',
                    onPressed: () async {
                      await notifier.save();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Сохранено')),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
