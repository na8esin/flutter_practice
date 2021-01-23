import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error_and_loading_screen.dart';

// 単純にCollectionGroupを使う
final detailsGroupProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collectionGroup('details').snapshots();
});

// collectionGroupのparentってとれなくない？
class CollectionGroupParent extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(detailsGroupProvider);
    return asyncValue.when(
        data: (data) {
          List<QueryDocumentSnapshot> docs = data.docs;
          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              QueryDocumentSnapshot docsE = docs.elementAt(index);
              return StreamBuilder(
                  stream: docsE.reference.parent.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snap2) {
                    if (snap2.hasError) Text('Something went wrong');
                    if (snap2.connectionState == ConnectionState.waiting)
                      Text("Loading");

                    if (snap2.data == null) return Text('parent is null.');
                    return ListTile(
                      title: Text(docsE.data()['title']),
                      // ↓のnameがnullで取れない。
                      // collectionGroupのparentって取れないんじゃない？
                      subtitle: Text(snap2.data.docs.first.data()['name']),
                    );
                  });
            },
          );
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}
