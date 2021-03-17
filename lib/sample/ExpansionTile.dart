import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 足りない要素
///   ハンバーガー
///   アニメーションしながら、広げたり閉じたりする
///     閉じるときって、サブメニューってどうすんの？文字？アイコン
///     そもそも閉じたり開いたりする必要ある？
/// 　左メニュの選択状態って同期する？
///
/// 足りない要素を補うためには？
///   パッケージを探す
///   Drawerを拡張する？

final flexProvider = StateNotifierProvider((ref) => FlexController());
final sideMenuflex = 3;

class FlexController extends StateNotifier<int> {
  FlexController() : super(sideMenuflex);

  void change() {
    state = state == sideMenuflex ? 1 : sideMenuflex;
  }
}

void main() {
  runApp(ProviderScope(
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: MyScaffold())));
}

class MyScaffold extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final flex = useProvider(flexProvider);
    return Scaffold(
      body: MyHomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => flex.change(),
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final flex = useProvider(flexProvider.state);
    return Row(
      children: [
        Expanded(
          flex: flex,
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                ExpansionTile(
                  trailing: flex == sideMenuflex ? null : SizedBox.shrink(),
                  expandedAlignment: Alignment.centerRight,
                  title: flex == sideMenuflex
                      ? Text('sample title')
                      : Icon(Icons.subtitles),
                  children: [
                    // childrenPaddingを使っても子要素同士の空白がうまくあかない
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: flex == sideMenuflex
                          ? Text('Text1')
                          : Icon(Icons.edit),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: flex == sideMenuflex
                          ? Text('Text2')
                          : Icon(Icons.list),
                    ),
                  ],
                ),
                ListTile(
                  title: Icon(Icons.person),
                  // 閉じたときの右側にある微妙な空白を調整するため
                  trailing: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        VerticalDivider(thickness: 1, width: 1),
        Expanded(
          flex: 13,
          child: Center(
            child: Text('Main'),
          ),
        )
      ],
    );
  }
}
