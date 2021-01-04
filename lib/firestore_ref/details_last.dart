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

// これでもローディングが止まらない
final _detailsLastProvider = FutureProvider((ref) async {
  Future<QuerySnapshot> fd1 = FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .collection('details')
      .snapshots()
      .last;
  Future<QuerySnapshot> fd2 = FirebaseFirestore.instance
      .collection('publics')
      .doc('FJeLdG1oSla7JGBaguka')
      .collection('details')
      .snapshots()
      .last;
  return Future.wait([fd1, fd2]);
});

// そもそもlastがダメ見たい
final _detailLastProvider = FutureProvider((ref) {
  Future<QuerySnapshot> fd1 = FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .collection('details')
      .snapshots()
      .last;
  return fd1;
});

final _detailStreamStreamProvider = StreamProvider((ref) {
  Stream<QuerySnapshot> fd1 = FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .collection('details')
      .snapshots();
  return fd1;
});

final _detailStreamStreamsProvider = StreamProvider<QuerySnapshot>((ref) {
  Stream<QuerySnapshot> fd1 = FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .collection('details')
      .snapshots();
  Stream<QuerySnapshot> fd2 = FirebaseFirestore.instance
      .collection('publics')
      .doc('FJeLdG1oSla7JGBaguka')
      .collection('details')
      .snapshots();
  // これだと2目しか出てこない
  return StreamGroup.merge<QuerySnapshot>([fd1, fd2]);
});

final _detail1StreamsProvider = StreamProvider<QuerySnapshot>((ref) {
  Stream<QuerySnapshot> fd1 = FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .collection('details')
      .snapshots();
  return fd1;
});

final publicStreamsProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots();
});

final $family = StreamProvider.family;
final detailfamily = $family<QuerySnapshot, CollectionReference>(
    (ref, CollectionReference colRef) {
  return colRef.snapshots();
});

final _mergeProvider = StateNotifierProvider<PublicDetails>((ref) {
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

  return PublicDetails(_foldList(fff));
});

class PublicDetails extends StateNotifier<List<PublicDetail>> {
  PublicDetails([List<PublicDetail> initial]) : super(initial ?? []);
}

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

class DetailsLast extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var pds = useProvider(_mergeProvider.state);

    return ListView.builder(
      itemCount: pds.length,
      itemBuilder: (context, index) {
        PublicDetail pc = pds.elementAt(index);
        return ListTile(
          title: Text(pc.detailtitle),
          subtitle: Text(pc.publicName),
        );
      },
    );
  }
}
