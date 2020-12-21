import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

class MyApp extends HookWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> dialogText = useState<String>('inbox');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // awaitじゃないとだめ
          await showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    title: Text(dialogText.value),
                    children: <Widget>[Text(dialogText.value)],
                  ));
          dialogText.value = dialogText.value == 'outbox' ? 'inbox' : 'outbox';
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
