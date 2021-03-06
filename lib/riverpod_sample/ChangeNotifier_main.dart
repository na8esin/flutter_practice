/**
 * StateNotifierとの比較のためのサンプルコード
 * ChangeNotifierが存在しない世界線で生きてきたけど、
 * flutter/galleryのコードで存在していたので
 */
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// A Counter example implemented with riverpod
// Repositoryを作らないパターン

void main() {
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class CounterController extends ChangeNotifier {
  CounterController();
  var _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

/// Providers are declared globally and specifies how to create a state
final counterControllerProvider =
    ChangeNotifierProvider((ref) => CounterController());

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final CounterController counter = useProvider(counterControllerProvider);
    final int count = counter.count;

    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
          // Consumer is a widget that allows you reading providers.
          // You could also use the hook "useProvider" if you uses flutter_hooks
          child: Text('$count')),
      floatingActionButton: FloatingActionButton(
        // The read method is an utility to read a provider without listening to it
        onPressed: () => counter.increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
