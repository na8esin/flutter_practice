import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'error_and_loading_screen.dart';

/**
 * こいつのmainは
 * two_stream_main.dart
 */

final publicStreamsProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots();
});

final $family = StreamProvider.family;
final detailfamily = $family<QuerySnapshot, CollectionReference>(
    (ref, CollectionReference colRef) {
  return colRef.snapshots();
});

// これだとloadingっていう文字が表示されたまま
// だから何とかStreamProviderで返せないといけない
final _mergeStreamsProvider = StreamProvider<List<PublicDetail>>((ref) {
  AsyncValue<QuerySnapshot> pub = ref.watch(publicStreamsProvider);
  Iterable<List<PublicDetail>> fff = pub.when(
      data: (data) {
        return data.docs.map((snap) {
          AsyncValue<QuerySnapshot> ccc =
              ref.watch(detailfamily(snap.reference.collection('details')));
          List<PublicDetail> ddd = ccc.when(
              data: (data) {
                return data.docs.map((snap2) =>
                    PublicDetail(snap.data()['name'], snap2.data()['title']));
              },
              loading: () => [PublicDetail('loading', 'loading')],
              error: (o, e) => [PublicDetail('error', 'error')]);
          return ddd.toList();
        });
      },
      loading: () => [
            [PublicDetail('loading', 'loading')]
          ],
      error: (o, e) => [
            [PublicDetail('error', 'error')]
          ]);

  var ggg = _foldList(fff);

  var controller = StreamController<List<PublicDetail>>();
  controller.add(ggg);
  return controller.stream;
});

class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}

List<PublicDetail> _foldList(Iterable<List<PublicDetail>> publicDetails) {
  return publicDetails.toList().fold<List<PublicDetail>>([],
      (List<PublicDetail> previousValue, Iterable<PublicDetail> element) {
    previousValue.addAll(element.map((e) => e));
    return previousValue;
  });
}

class DetailsLast2 extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(publicStreamsProvider);

    // widgetを返さないとだめ
    return asyncValue.when(
        data: (data) {
          Iterable<List<ListTile>> listTiles = data.docs.map((snap) {
            AsyncValue<QuerySnapshot> asyncValue2 =
                useProvider(detailfamily(snap.reference.collection('details')));

            // whenをwidgetで返さないと
            // List<ListTile> ddd =
            return asyncValue2.when(
              data: (data) {
                List<ListTile> tiles = data.docs
                    .map<ListTile>((snap2) => ListTile(
                          title: Text(snap2.data()['title']),
                          subtitle: Text(snap.data()['name']),
                        ))
                    .toList();
                return tiles;
              },
              loading: () =>
                  [ListTile(title: Text('loading'), subtitle: Text('loading'))],
              error: (o, e) =>
                  [ListTile(title: Text('error'), subtitle: Text('error'))],
            );
          });
          return ListView(children: _foldListTile(listTiles));
        },
        loading: () => ListView(children: [
              ListTile(title: Text('loading'), subtitle: Text('loading')),
            ]),
        error: (o, e) => ListView(children: [
              ListTile(title: Text('error'), subtitle: Text('error'))
            ]));
  }
}

List<ListTile> _foldListTile(Iterable<List<ListTile>> pds) {
  return pds.toList().fold<List<ListTile>>([],
      (List<ListTile> previousValue, Iterable<ListTile> element) {
    previousValue.addAll(element.map((e) => e));
    return previousValue;
  });
}

List<ListTile> pdsToListTile(List<PublicDetail> pds) {
  return pds.map((e) => ListTile(
        title: Text(e.detailtitle),
        subtitle: Text(e.publicName),
      ));
}
