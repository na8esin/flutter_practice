import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver_extended.dart';

// https://pub.dev/documentation/integration_test/latest/
// からの
// https://github.com/flutter/plugins/blob/master/packages/integration_test/example/test_driver/extended_integration_test.dart

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();
  await integrationDriver(
    driver: driver,
    onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
      return true;
    },
  );
}
