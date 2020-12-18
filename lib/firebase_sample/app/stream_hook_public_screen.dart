import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/error.dart';
import '../common/loading.dart';

final publicProvider = StreamProvider<QuerySnapshot>((ref) {
  CollectionReference public = FirebaseFirestore.instance.collection('public');
  public.doc().collection('details');
  return public.snapshots();
});

class StreamRiverPodPublicScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> publicSnapshot = useProvider(publicProvider);
    return publicSnapshot.when(
        loading: () => Loading(),
        error: (error, stack) => Error(),
        data: (public) => Scaffold(
            appBar: AppBar(
              title: Text('StreamRiverPodPublicScreen'),
            ),
            body: Center(
                child: ListView(
              children: public.docs.map((DocumentSnapshot document) {
                return ListTile(
                  title: Text(document.data()['name']),
                  subtitle: Text(document.data()['subname']),
                  trailing: Text('tr'),
                );
              }).toList(),
            ))));
  }
}
