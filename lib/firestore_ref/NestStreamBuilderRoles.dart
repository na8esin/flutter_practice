import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots().map(
      (e) => e.docs.map((e) => UserRoles(e.id, e.data()['roles'])).toList());
});

class NestStreamBuilderRoles extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return useProvider(publicProvider).when(
        data: (userRolesList) {
          List<Widget> listTiles = [];
          for (var userRoles in userRolesList) {
            // 1つのpublicは複数のroleがある
            List<Widget> nameWidgets = [];
            for (var role in userRoles.roles) {
              nameWidgets.add(MyStreamHookWidget(role));
            }
            Widget namesWidget = Column(
              children: nameWidgets,
            );
            listTiles.add(ListTile(
              title: Text(userRoles.id),
              subtitle: namesWidget,
            ));
          }

          return ListView(
            children: listTiles,
          );
        },
        loading: () => Text('loading'),
        error: (e, s) => Text(e.toString()));
  }
}

class UserRoles {
  final id;
  // いきなりDocumentReferenceにキャストできないからこんな感じ
  final roles;
  UserRoles(this.id, this.roles);
}

class MyStreamBuilder extends HookWidget {
  MyStreamBuilder(this.role);
  final role;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: (role as DocumentReference).snapshots(),
      builder: (context, snap2) {
        if (snap2.hasError) return Text('snap2 error');
        if (snap2.connectionState == ConnectionState.waiting)
          return Text("snap2 Loading");

        return Text(snap2.data['name']);
      },
    );
  }
}

final $family = StreamProvider.family;
final roleProvider = $family<String, dynamic>((ref, role) {
  return (role as DocumentReference)
      .snapshots()
      .map((event) => event.data()['name']);
});

// StreamProviderに置き換えるとどうか？
// これは動かない。。。
class MyStreamHookWidget extends HookWidget {
  MyStreamHookWidget(this.role);
  final role;
  @override
  Widget build(BuildContext context) {
    return useProvider(roleProvider(role)).when(
        data: (data) => Text(data),
        loading: () => Text('lo'),
        error: (e, s) => Text(e.toString()));
  }
}
