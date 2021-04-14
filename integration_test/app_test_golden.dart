// Imports the Flutter Driver API.
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:flutter_practice/sample/default_sample_main.dart' as app;

/// integration_testだとgoldenのキャプチャって使えないよね？
/// の確認 -> 使えない

Future<void> main() async {
  await loadAppFonts();

  // https://github.com/flutter/flutter/issues/72063#issuecomment-753384244
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    setUpAll(() async {});

    testWidgets('tap on the floating action button; verify counter',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'app_test_golden', autoHeight: true);

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
