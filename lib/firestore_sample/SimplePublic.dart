import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _publicProvider = StreamProvider((ref) {
  return FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .snapshots()
      .map((e) {
    return e.data()!.entries.toList();
  });
});

class SimplePublic extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final asyncValue = useProvider(_publicProvider);
    return Container(
        child: asyncValue.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data.elementAt(index);
                  return Text('${item.key} : ${item.value}');
                },
              );
            },
            loading: () => Text(''),
            error: (e, s) => Text(e.toString())));
  }
}
