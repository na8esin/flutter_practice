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

class MyForm {
  MyForm({
    this.email = '',
    this.submitted = false,
  });
  bool submitted;
  String email;
}

// form model的な感じ
class MyFormController extends StateNotifier<MyForm> {
  MyFormController() : super(MyForm());
  bool validate() {
    if (state.email.isNotEmpty) {
      return true;
    }
    return false;
  }

  String validator(String value) {
    print('validator');
    setFormValue(value);
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void setFormValue(String value) {
    state.email = value;
  }

  void setSubmitted(bool value) {
    state.submitted = value;
  }

  String get emailErrorText {
    print('emailErrorText');
    if (state.submitted && !validate()) {
      return 'Please enter some text';
    }
    return null;
  }

  String get email {
    return state.email;
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
    final textEditingController = useTextEditingController();

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // TODO: errorTextが更新される方法がわからない
            decoration: InputDecoration(errorText: myForm.emailErrorText),
            onChanged: myForm.setFormValue,
            controller: textEditingController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                myForm.setSubmitted(true);
                if (myForm.validate()) {
                  // If the form is valid, display a Snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Processing Data:' + myForm.email)));
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
