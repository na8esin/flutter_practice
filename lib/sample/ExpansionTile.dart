import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// たりない要素としては、ハンバーガー

final flexProvider = StateNotifierProvider((ref) => FlexController());

class FlexController extends StateNotifier<int> {
  FlexController() : super(2);

  void change() {
    state = state == 2 ? 1 : 2;
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
            alignment: Alignment.topLeft,
            child: ExpansionTile(
              expandedAlignment: Alignment.centerRight,
              title: flex == 2 ? Text('sample title') : Icon(Icons.subtitles),
              children: [
                // childrenPaddingを使っても子要素同士の空白がうまくあかない
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Text1'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Text2'),
                ),
              ],
            ),
          ),
        ),
        VerticalDivider(thickness: 1, width: 1),
        Expanded(
          flex: 8,
          child: Center(
            child: Text('Main'),
          ),
        )
      ],
    );
  }
}
