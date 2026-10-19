// lib/config/providers/onboarding_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Instância já carregada em `main()` e injetada com `overrideWithValue`.
/// Assim o router lê o estado do onboarding de forma síncrona, sem
/// `FutureProvider` nem ecrã de loading extra.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(
    'sharedPreferencesProvider tem de ser override em main().',
  ),
);

/// Tempo mínimo de splash (marca visível + tempo para a sessão ser restaurada).
/// Passa a ter valor ao fim de ~1,2 s e o router sai do splash nessa altura.
final splashDoneProvider = FutureProvider<bool>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 1200));
  return true;
});

/// `true` quando o utilizador já viu (ou saltou) o onboarding.
final onboardingCompleteProvider = NotifierProvider<OnboardingController, bool>(
  OnboardingController.new,
);

class OnboardingController extends Notifier<bool> {
  static const _key = 'onboardingComplete';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;

  /// Atualiza o estado primeiro (o router reage logo) e persiste a seguir.
  Future<void> complete() async {
    state = true;
    await ref.read(sharedPreferencesProvider).setBool(_key, true);
  }
}
