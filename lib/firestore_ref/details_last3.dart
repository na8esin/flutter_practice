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

final $family = StreamProvider.autoDispose.family;
final detailfamily = $family<QuerySnapshot, CollectionReference>(
    (ref, CollectionReference colRef) {
  return colRef.snapshots();
});

class DetailsLast2ListViewSeparated extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(publicStreamsProvider);

    return asyncValue.when(
        data: (data) {
          // ListView.separatedなら動くけど、ListViewだとだめ
          return ListView.separated(
            itemCount: data.docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data.docs.elementAt(index).data()['name']),
                onTap: () {},
              );
            },
          );
        },
        loading: () => ListView(children: [
              ListTile(title: Text('loading'), subtitle: Text('loading')),
            ]),
        error: (o, e) => ListView(children: [
              ListTile(title: Text('error'), subtitle: Text('error'))
            ]));
  }
}

// ListViewだとLoadingのまま
class DetailsLast2Listview extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(publicStreamsProvider);

    return asyncValue.when(
        data: (data) {
          List<ListTile> lists = data.docs
              .map((e) => ListTile(
                    title: e.data()['name'],
                  ))
              .toList();
          return ListView(children: lists);
        },
        loading: () => ListView(children: [
              ListTile(title: Text('loading'), subtitle: Text('loading')),
            ]),
        error: (o, e) => ListView(children: [
              ListTile(title: Text('error'), subtitle: Text('error'))
            ]));
  }
}

class DetailsLast2ListViewSeparatedNest extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(publicStreamsProvider);

    return asyncValue.when(
        data: (data) {
          return _ListTile(data);
        },
        loading: () => ListView(children: [
              ListTile(title: Text('loading'), subtitle: Text('loading')),
            ]),
        error: (o, e) => ListView(children: [
              ListTile(title: Text('error'), subtitle: Text('error'))
            ]));
  }
}

// 抽出
class _ListTile extends HookWidget {
  _ListTile(this.data);
  final QuerySnapshot data;
  @override
  Widget build(BuildContext context) {
    Iterable<List<ListTile>> listTiles = data.docs.map((snap) {
      //return _ListTile2(snap);
    });
    //return ListView(children: _foldListTile(listTiles));
    return ListView.separated(
        itemCount: _foldListTile(listTiles).length,
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemBuilder: (context, index) {
          return _foldListTile(listTiles).elementAt(index);
        });
  }
}

/*
class _ListTile2 extends HookWidget {
  _ListTile2(this.snap);
  final snap;
  @override
  Widget build(BuildContext context) {
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
  }
}
*/
List<ListTile> _foldListTile(Iterable<List<ListTile>> pds) {
  return pds.toList().fold<List<ListTile>>([],
      (List<ListTile> previousValue, Iterable<ListTile> element) {
    previousValue.addAll(element.map((e) => e));
    return previousValue;
  });
}
