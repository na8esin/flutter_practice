import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_widget.dart';

class Login extends StatelessWidget {
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

class MyCustomForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final emailErrorText = useState<String>(null);
    final passwordErrorText = useState<String>(null);
    final emailEditingController = useTextEditingController();
    final passwordEditingController =
        useTextEditingController(text: 'password');
    final firebaseAuth = useProvider(firebaseAuthProvider);
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: emailEditingController,
            decoration: InputDecoration(
                errorText: emailErrorText.value, labelText: 'email'),
          ),
          TextFormField(
            controller: passwordEditingController,
            decoration: InputDecoration(
                errorText: passwordErrorText.value, labelText: "password"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                emailErrorText.value = null;
                if (emailEditingController.text.isEmpty) {
                  emailErrorText.value = "some error";
                  return;
                }
                if (passwordEditingController.text.isEmpty) {
                  passwordErrorText.value = "some error";
                  return;
                }
                try {
                  await firebaseAuth.signInWithCredential(
                      EmailAuthProvider.credential(
                          email: emailEditingController.text,
                          password: passwordEditingController.text));
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$e'),
                  ));
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
