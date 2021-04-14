// Imports the Flutter Driver API.
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_practice/sample/default_sample_main.dart' as app;

// https://flutter.dev/docs/testing/integration-tests#migrating-from-flutter_driver
//   を見て変更

// https://github.com/flutter/flutter/issues/72063#issuecomment-753384244

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized()
          as IntegrationTestWidgetsFlutterBinding;

  testWidgets('verify screenshot', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Take a screenshot.
    await binding.takeScreenshot('platform_name');
  });
}
