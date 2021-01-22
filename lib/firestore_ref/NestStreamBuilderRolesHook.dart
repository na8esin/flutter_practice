import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicProvider = StreamProvider((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots();
});

final rolesProvider =
    StreamProvider.family((ref, List<UserRoles> userRolesList) {});

class NestStreamBuilderRolesHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return useProvider(publicProvider).when(
        data: (snapshot1) {
          // List<DocumentReference>
          List<UserRoles> userRolesList = snapshot1.docs
              .map((docSnap) => UserRoles(docSnap.id, docSnap.data()['roles']))
              .toList();

          List<Widget> listTiles = [];
          for (var userRoles in userRolesList) {
            // 1つのpublicは複数のroleがある
            List<Widget> nameWidgets = [];
            for (var role in userRoles.roles) {
              nameWidgets.add(StreamBuilder(
                stream: (role as DocumentReference).snapshots(),
                builder: (context, snap2) {
                  if (snap2.hasError) return Text('snap2 error');
                  if (snap2.connectionState == ConnectionState.waiting)
                    return Text("snap2 Loading");

                  return Text(snap2.data['name']);
                },
              ));
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
  final roles;
  UserRoles(this.id, this.roles);
}
