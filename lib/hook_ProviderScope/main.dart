import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class Counter extends StateNotifier<int> {
  Counter(state) : super(state);
  increment() {
    state++;
  }
}

final screenProvider = StateNotifierProvider<Counter>((state) => Counter(0));

// 何らかの事情でHookWidgetにできなかったとする
class MyApp extends StatelessWidget {
//class MyApp extends HookWidget { // HookWidgetならもちろんうまくいく
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // なのでContainerを直接使う
    final container = ProviderScope.containerOf(context);
    Counter counter = container.read(screenProvider);
    // HookWidgetが使えた場合
    //Counter counter = useProvider(screenProvider);
    return MaterialApp(
      home: Scaffold(
        body: Home(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            counter.increment();
          },
        ),
      ),
    );
  }
}

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    int count = useProvider(screenProvider.state);
    return Text('${count}');
  }
}
