import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // authStateChanges()が正常に動くまでちょっと待つ
  await Future.delayed(Duration(seconds: 1));
  runApp(
    // Appはconstじゃなくても起動はするみたい
    ProviderScope(child: App()),
  );
}
