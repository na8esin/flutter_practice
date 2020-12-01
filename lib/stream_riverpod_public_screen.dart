import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error.dart';
import 'loading.dart';

final publicProvider = StreamProvider<QuerySnapshot>((ref) {
  CollectionReference public = FirebaseFirestore.instance.collection('public');
  return public.snapshots();
});

class StreamRiverPodPublicScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> public = useProvider(publicProvider);
    return public.when(
        loading: () => Loading(),
        error: (error, stack) => Error(),
        data: (public) => Scaffold(
            appBar: AppBar(
              title: Text('StreamRiverPodPublicScreen'),
            ),
            body: Center(
                child: new ListView(
              children: public.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document.data()['name']),
                  subtitle: new Text(document.data()['subname']),
                );
              }).toList(),
            ))));
  }
}
