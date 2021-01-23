import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Public {
  final String id;
  final String name;
  Public(this.id, this.name);
}

class PubDetail {
  final String pubName;
  final String detailTile;
  PubDetail(this.pubName, this.detailTile);
}

final publicProvider = StreamProvider<List<Public>>((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots().map((e) =>
      e.docs.map<Public>((e) => Public(e.id, e.data()['name'])).toList());
});

// 最後がStateProviderでもデータが追加されれば即時反映
final pubDetailProvider = StateProvider<List<PubDetail>>((ref) {
  final pubAsync = ref.watch(publicProvider);
  return pubAsync.when(
      data: (publics) {
        return publics.fold<List<PubDetail>>([],
            (List<PubDetail> previous, public) {
          final detailAsync = ref.watch(detailProvider(public.id));
          final pubDetails = detailAsync.when(
              data: (details) {
                return details
                    .map<PubDetail>((e) => PubDetail(public.name, e))
                    .toList();
              },
              loading: () => [PubDetail('lo2', '')],
              error: (e, s) => [PubDetail(e.toString(), '')]);
          previous.addAll(pubDetails);
          return previous;
        });
      },
      loading: () => [PubDetail('lo', '')],
      error: (e, s) => [PubDetail('er', '')]);
});

final $family = StreamProvider.family;
final detailProvider = $family<List<String>, String>((ref, String id) {
  return FirebaseFirestore.instance
      .collection('publics')
      .doc(id)
      .collection('details')
      .snapshots()
      .map(
          (event) => event.docs.map<String>((e) => e.data()['title']).toList());
});

class HookPubDetail extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: useProvider(pubDetailProvider).state.map((e) {
        if (e == null) return Text('');
        return Text('public: ${e.pubName}, detail: ${e.detailTile}');
      }).toList(),
    );
  }
}
