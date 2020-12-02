import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(child: MyApp()),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

/*
  flutter_hooksを使った簡単なバリデーションサンプル
 */
class MyCustomForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final errorText = useState<String>(null);
    final textEditingController = useTextEditingController();
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(errorText: errorText.value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                print(textEditingController.text);
                errorText.value = null;
                if (textEditingController.text.isEmpty) {
                  errorText.value = "some error";
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
