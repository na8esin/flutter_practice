/// ***************************************************
/// Copyright 2019-2020 eBay Inc.
///
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file or at
/// https://opensource.org/licenses/BSD-3-Clause
/// ***************************************************

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:flutter_practice/sample/font_samaple.dart';

Future<void> main() async {
  await loadAppFonts();
  group('GoldenBuilder', () {
    testGoldens('Column layout example', (tester) async {
      await tester.pumpWidget(MyApp());
      await screenMatchesGolden(tester, 'golden_font_sample', autoHeight: true);
    });
  });
}
