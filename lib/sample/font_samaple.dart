import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'こんにちは、今日は天気ですね',
        // Set Raleway as the default app font.
        theme: ThemeData(fontFamily: 'NotoSansJP'),
        home: Scaffold(
          body: MyHomePage(),
        ));
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '今日の天気はきっと晴れるでしょう。桜も満開です。',
        style: TextStyle(fontFamily: 'NotoSansJP'),
      ),
    );
  }
}
