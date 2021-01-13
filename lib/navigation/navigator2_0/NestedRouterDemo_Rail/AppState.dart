import 'package:hooks_riverpod/hooks_riverpod.dart';

final appProvider = StateNotifierProvider((ref) => AppController(0));

class AppController extends StateNotifier<int> {
  AppController(state) : super(state);

  onDestinationSelected(int newIndex) {
    state = newIndex;
  }

  setIndex(int value) {
    state = value;
  }

  get getIndex => state;
}
