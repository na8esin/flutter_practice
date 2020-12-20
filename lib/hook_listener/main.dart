import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

final countStateControllerProvider = StateNotifierProvider(
  (ref) => CountStateController(
    CountState(0),
  ),
);

class CountState {
  CountState(this.count);
  final int count;
}

class CountStateController extends StateNotifier<CountState> {
  CountStateController(CountState state) : super(state);

  void increment() {
    state = CountState(state.count + 1);
  }

  void erase() {
    state = CountState(0);
  }
}

final countStateProvider = Provider.autoDispose(
    (ref) => ref.watch(countStateControllerProvider.state));

class MyApp extends HookWidget {
  const MyApp({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final prop = useProvider(countStateControllerProvider);
    return ProviderListener(
      provider: countStateProvider,
      onChange: (context, CountState countState) {
        if (countState.count % 5 == 0) {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text('New Category'),
              children: <Widget>[MyForm()],
            ),
          );
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          // The read method is an utility to read a provider without listening to it
          onPressed: () => prop.increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class MyForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final prop = useProvider(countStateControllerProvider);
    final containerWidth = MediaQuery.of(context).size.width * 0.8;
    final containerheight = MediaQuery.of(context).size.height * 0.8;
    return Container(
      width: containerWidth,
      height: containerheight,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (newValue) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Sub Name',
                ),
                onChanged: (newValue) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a sub name';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      prop.erase();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: RaisedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
