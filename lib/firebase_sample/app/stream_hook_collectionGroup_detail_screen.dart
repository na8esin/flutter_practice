import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/error.dart';
import '../common/loading.dart';

final detailsProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collectionGroup('details').snapshots();
});

class StreamDetailsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> detailsSnapshot = useProvider(detailsProvider);
    return detailsSnapshot.when(
        loading: () => Loading(),
        error: (error, stack) => Error(error: error),
        data: (data) => Scaffold(
            appBar: AppBar(
              title: Text('detailsSnapshot'),
            ),
            body: Center(
                child: ListView(
              children: data.docs.map((DocumentSnapshot doc) {
                return ListTile(
                  title: Text(doc.data()!['title']),
                );
              }).toList(),
            ))));
  }
}
