import 'dart:async';

import 'package:firebase_admin_interop/firebase_admin_interop.dart';

// なんか動かない
Future<void> main() async {
  final serviceAccountKeyFilename =
      '/Users/t.watanabe/.config/firebase/practice-da34f-firebase-adminsdk-ueykj-15aeda6703.json';
  final admin = FirebaseAdmin.instance;
  final cert = admin.certFromPath(serviceAccountKeyFilename);
  final app = admin.initializeApp(new AppOptions(
    credential: cert,
    databaseURL: 'https://practice-da34f.firebaseio.com',
  ));
  final ref = app.firestore();
  ref
      .collection('test-path')
      .document()
      .setData(DocumentData.fromMap({'title': 'uum'}));
}
