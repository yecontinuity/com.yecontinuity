// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'YEContinuity';

  @override
  String get tabHome => 'Início';

  @override
  String get tabExplorer => 'Explorar';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get tabSettings => 'Definições';

  @override
  String get tabAdd => 'Adicionar';

  @override
  String get tabOrders => 'Pedidos';

  @override
  String get homeTitle => 'Início';

  @override
  String get homeBody => 'Cada separador mantém a sua própria pilha de navegação e posição de scroll.';

  @override
  String get openDetails => 'Abrir detalhes';

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens',
      one: '1 item',
      zero: 'Sem itens',
    );
    return '$_temp0';
  }

  @override
  String detailsTitle(String id) {
    return 'Item $id';
  }

  @override
  String get searchTitle => 'Pesquisa';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSystem => 'Predefinição do sistema';

  @override
  String get searchHint => 'Pesquisar produtos';

  @override
  String get availableItems => 'Os artigos disponíveis';

  @override
  String get seeMore => 'Ver mais';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';
}
