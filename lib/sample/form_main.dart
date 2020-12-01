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
        body: MyCustomFormState(),
      ),
    );
  }
}

class MyFormController extends StateNotifier<String> {
  MyFormController() : super('');
  bool validate() {
    if (state.isNotEmpty) {
      return true;
    }
    return false;
  }

  String validator(String value) {
    setFormValue(value);
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void setFormValue(String value) {
    state = value;
  }
}

final myFormControllerProvider =
    StateNotifierProvider((ref) => MyFormController());

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final MyFormController myForm = useProvider(myFormControllerProvider);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: myForm.validator,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (myForm.validate()) {
                  // If the form is valid, display a Snackbar.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
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
