import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots().map(
      (e) => e.docs.map((e) => UserRoles(e.id, e.data()!['roles'])).toList());
});

// StreamBuilderを分離した例
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
              nameWidgets.add(MyStreamBuilder(role));
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
  final List roles;
  UserRoles(this.id, this.roles);
}

class MyStreamBuilder extends HookWidget {
  MyStreamBuilder(this.role);
  final DocumentReference role;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: role.snapshots(),
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasError) return Text('snap2 error');
        if (snap.connectionState == ConnectionState.waiting)
          return Text("snap2 Loading");

        return Text('${snap.data['name']}');
      },
    );
  }
}

final $family = StreamProvider.family;
final roleProvider = $family<String, dynamic>((ref, role) {
  return (role as DocumentReference)
      .snapshots()
      .map((event) => event.data()!['name']);
});
