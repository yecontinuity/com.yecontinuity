// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'YEContinuity';

  @override
  String get tabHome => 'Home';

  @override
  String get tabExplorer => 'Explorer';

  @override
  String get tabProfile => 'Profile';

  @override
  String get tabSettings => 'Settings';

  @override
  String get tabAdd => 'Add';

  @override
  String get tabOrders => 'Orders';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeBody => 'Each tab keeps its own navigation stack and scroll position.';

  @override
  String get openDetails => 'Open details';

  @override
  String itemsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String detailsTitle(String id) {
    return 'Item $id';
  }

  @override
  String get searchTitle => 'Search';

  @override
  String get profileTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get searchHint => 'Search products';

  @override
  String get availableItems => 'Available items';

  @override
  String get seeMore => 'See more';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';
}
