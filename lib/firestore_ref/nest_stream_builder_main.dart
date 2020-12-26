import 'package:async/async.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'public.dart';
import 'detail.dart';
import 'error_and_loading_screen.dart';

/**
 * two_stream_builder_main
 * の苦しまぎれのColumnを消したいのに頑張ったが、未完成
 */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

List<Map<String, dynamic>> listListTile = [
  {'title': Text(Body().toStringShort()), 'builder': Body()},
];

class MyApp extends HookWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemCount: listListTile.length,
            separatorBuilder: (context, index) => const SizedBox(height: 3),
            itemBuilder: (context, index) {
              return ListTile(
                  title: listListTile[index]['title'],
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                body: listListTile[index]['builder'],
                              ))));
            }));
  }
}

final publicsProvider = StreamProvider.autoDispose((ref) {
  // await しても変わんない
  //Stream<List<PublicDoc>> awaitPubStream = await PublicsRef().documents();
  return PublicsRef().documents();
});

class Body extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('publics').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.hasError) return Text('Something went wrong');
        if (snapshot1.connectionState == ConnectionState.waiting)
          return Text("Loading");

        // pubulicをループさせないといけないんだよなー。
        // for (DocumentSnapshot document in snapshot1.data.docs)
        return StreamBuilder(
          stream: _detailStream('id'),
          builder: (context, snapshot2) {
            return Container();
          },
        );
      },
    );
  }

  Stream<QuerySnapshot> _detailStream(String publicId) {
    return FirebaseFirestore.instance
        .collection('publics')
        .doc(publicId)
        .collection('details')
        .snapshots();
  }
}

/**
 * idがとれた
          return ListView(children: [
          for (DocumentSnapshot document in snapshot1.data.docs)
            ListTile(
              title: Text(document.data()['name']),
              subtitle: Text(document.id),
            )
        ]);
 */

/* 基本の形
snapshot1.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['name']),
            );
          }).toList(),
          */
