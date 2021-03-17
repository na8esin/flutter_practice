import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicProvider = StreamProvider<List<dynamic>>((ref) {
  return FirebaseFirestore.instance
      .collection('publics')
      .doc('0YPJmTVo631kHkpQgP47')
      .snapshots()
      .map((e) => e.data()!['roles']);
});

final $family = StreamProvider.family;
// 第二引数が、id(String)の場合はちゃんと動く
// DocumentReferenceだとloadingのままになる
final roleProvider = $family<String, String>((ref, id) {
  return FirebaseFirestore.instance
      .collection('roles')
      .doc(id)
      .snapshots()
      .map((e) => e.data()!['name']);
});

class OnePublicRoles extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: useProvider(publicProvider)
          .when(
              data: (List<dynamic> roles) => roles,
              loading: () => [null],
              error: (e, s) => [null])
          .map((e) => MyStreamHookWidget(e))
          .toList(),
    );
  }
}

class MyStreamHookWidget extends HookWidget {
  MyStreamHookWidget(this.role);
  final role;
  @override
  Widget build(BuildContext context) {
    if (role == null) return Text('null');
    return useProvider(roleProvider(role.id)).when(
        data: (data) => Text(data),
        loading: () => Text('lo'),
        error: (e, s) => Text(e.toString()));
  }
}
