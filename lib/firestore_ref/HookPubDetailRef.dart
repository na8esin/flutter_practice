import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/public.dart';
import 'model/detail.dart';

class PubDetail {
  final String pubName;
  final String detailTile;
  PubDetail(this.pubName, this.detailTile);
}

final publicProvider = StreamProvider<List<PublicDoc>>((ref) {
  return publicsRef.documents();
});

// 最後がStateProviderでもデータが追加されれば即時反映
final pubDetailProvider = StateProvider<List<PubDetail>>((ref) {
  final pubAsync = ref.watch(publicProvider);
  return pubAsync.when(
      data: (publics) {
        return publics.fold<List<PubDetail>>([],
            (List<PubDetail> previous, public) {
          final detailAsync = ref.watch(detailProvider(public));
          final pubDetails = detailAsync.when(
              data: (details) {
                return details
                    .map<PubDetail>(
                        (e) => PubDetail(public.entity.name, e.entity.title))
                    .toList();
              },
              loading: () => [PubDetail('lo2', '')],
              error: (e, s) => [PubDetail(e.toString(), 'e')]);
          previous.addAll(pubDetails);
          return previous;
        });
      },
      loading: () => [PubDetail('lo', '')],
      error: (e, s) => [PubDetail(e.toString(), 'er')]);
});

// PublicDocはちゃんとしてるから、familyの引数として使える
final $family = StreamProvider.family;
final detailProvider =
    $family<List<DetailDoc>, PublicDoc>((ref, PublicDoc doc) {
  return DetailsRef(publicDoc: doc).documents();
});

class HookPubDetailRef extends HookWidget {
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
