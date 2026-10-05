import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void changepage(int value) => state = value;
}

final bottomNavigationProvider =
    NotifierProvider<BottomNavigationNotifier, int>(
      BottomNavigationNotifier.new,
    );
