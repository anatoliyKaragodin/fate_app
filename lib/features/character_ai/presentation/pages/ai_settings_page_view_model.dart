import 'package:fate_app/core/di/di_container.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiSettingsPageViewModelProvider =
    StateNotifierProvider<AiSettingsPageViewModel, AiSettingsState>(
  (ref) => AiSettingsPageViewModel(getIt<AiSettingsRepository>()),
);

class AiSettingsState {
  final AiProvider selectedProvider;
  final bool loading;

  const AiSettingsState({
    this.selectedProvider = AiProvider.groq,
    this.loading = true,
  });

  AiSettingsState copyWith({
    AiProvider? selectedProvider,
    bool? loading,
  }) {
    return AiSettingsState(
      selectedProvider: selectedProvider ?? this.selectedProvider,
      loading: loading ?? this.loading,
    );
  }
}

class AiSettingsPageViewModel extends StateNotifier<AiSettingsState> {
  AiSettingsPageViewModel(this._repo) : super(const AiSettingsState()) {
    _load();
  }

  final AiSettingsRepository _repo;

  Future<void> _load() async {
    final p = await _repo.getSelectedProvider();
    state = state.copyWith(selectedProvider: p, loading: false);
  }

  void setProvider(AiProvider provider) {
    state = state.copyWith(selectedProvider: provider);
  }

  Future<void> save() async {
    await _repo.setSelectedProvider(state.selectedProvider);
    await _load();
  }
}
