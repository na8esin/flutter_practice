import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/riverpod_sample/pod_sample_no_repo_main.dart';

void main() {
  testWidgets('Render the default Counter', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    // [No MediaQuery widget ancestor found]が発生する
    //await tester.pumpWidget(const ProviderScope(child: Home()));
    final titleFinder = find.text('Counter example');

    expect(titleFinder, findsOneWidget);
  });
}
