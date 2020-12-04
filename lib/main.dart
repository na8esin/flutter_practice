import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // Appはconstじゃなくても起動はするみたい
    ProviderScope(child: App()),
  );
}
