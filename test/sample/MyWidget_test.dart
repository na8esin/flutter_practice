import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_practice/sample/MyWidget.dart';

// golden関連は下記のページから
// https://halesworth.org/snapshot-testing-with-flutter-golden
// flutter_testに組み込まれてるgoldenだとフォントが対応されてないっぽい
// https://stackoverflow.com/questions/59104547/how-to-check-font-text-on-flutter-golden-test

void main() {
  group('ACME Widget', () {
    // Define a test. The TestWidgets function also provides a WidgetTester
    // to work with. The WidgetTester allows building and interacting
    // with widgets in the test environment.
    testWidgets('MyWidget has a title and message',
        (WidgetTester tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
      await expectLater(
          find.byType(MyWidget), matchesGoldenFile('goldens/widget.png'));
      // Create the Finders.
      final titleFinder = find.text('T');
      final messageFinder = find.text('M');

      // Use the `findsOneWidget` matcher provided by flutter_test to
      // verify that the Text widgets appear exactly once in the widget tree.
      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
    });
  });
}
