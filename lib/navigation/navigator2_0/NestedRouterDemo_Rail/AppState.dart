import 'package:hooks_riverpod/hooks_riverpod.dart';

final appProvider =
    StateNotifierProvider((ref) => AppController(AppState(selectedIndex: 0)));

class AppState {
  AppState({this.selectedIndex});
  // NavigationRailが変更されるたびに変わる
  final int selectedIndex;
}

class AppController extends StateNotifier<AppState> {
  AppController(AppState state) : super(state);

  int get selectedIndex => state.selectedIndex;

  set selectedIndex(int idx) {
    state = AppState(
      selectedIndex: idx,
    );

    // _selectedIndex == 1の時って要するにsettingの時
    // BottomNavigationBarのstateをBooksAppStateみたいな名前のstateで
    // 管理してるのが違和感。。。
    //if (_selectedIndex == 1) {
    // Remove this line if you want to keep the selected book when navigating
    // between "settings" and "home" which book was selected when Settings is
    // tapped.
    //selectedBook = null;
    //}
  }
}
