import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error_and_loading_screen.dart';

/**
 * collectionGroupのparentってとれるのか検証
 * collectionGroup_main.dartの例と何も変わらなかった。
 */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

List<Map<String, dynamic>> listListTile = [
  {
    'title': Text(DetailsGroupBody().toStringShort()),
    'builder': DetailsGroupBody()
  }
];

// 初めの選択ページ
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

// 単純にCollectionGroupを使う
final detailsGroupProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collectionGroup('details').snapshots();
});

class DetailsGroupBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(detailsGroupProvider);
    return asyncValue.when(
        data: (QuerySnapshot data) {
          List<QueryDocumentSnapshot> docs = data.docs;
          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              QueryDocumentSnapshot docsE = docs.elementAt(index);

              return StreamBuilder(
                  stream: docsE.reference.parent.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snap2) {
                    if (snap2.hasError) return Text('Something went wrong');
                    if (snap2.connectionState == ConnectionState.waiting)
                      return Text("Loading");

                    var d2 = snap2.data.docs.first;
                    return ListTile(
                      title: Text(docsE.data()['title']),
                      // ↓のnameがnullで取れない。
                      // collectionGroupのparentって取れないんじゃない？
                      subtitle: Text(d2.data()['name'] ?? 'no data.'),
                    );
                  });
            },
          );
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}
