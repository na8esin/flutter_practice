import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicIdsProvider = StreamProvider<List<String>>((ref) {
  return FirebaseFirestore.instance
      .collection('publics')
      .snapshots()
      .map((e) => e.docs.map((e) => e.id).toList());
});

final $family = StreamProvider.family;
final publicProvider = $family<String, String>((ref, String id) {
  return FirebaseFirestore.instance
      .collection('publics')
      .doc(id)
      .snapshots()
      .map((e) => e.data()['name']);
});

class StreamFamily extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: useProvider(publicIdsProvider)
          .when(
              data: (List<String> data) => data,
              loading: () => ['loading'],
              error: (e, s) => [e.toString()])
          .map((e) => StreamHookWidget(e))
          .toList(),
    );
  }
}

class StreamHookWidget extends HookWidget {
  StreamHookWidget(this.id);
  final String id;
  @override
  Widget build(BuildContext context) {
    return useProvider(publicProvider(id)).when(
        data: (data) => Text(data),
        loading: () => Text('loading'),
        error: (e, s) => Text(e.toString()));
  }
}
