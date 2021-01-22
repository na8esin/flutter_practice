import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NestStreamBuilderRolesHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('publics').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
          if (snapshot1.hasError) return Text('Something went wrong');
          if (snapshot1.connectionState == ConnectionState.waiting)
            return Text("Loading");

          // List<DocumentReference>
          List<UserRoles> userRolesList = snapshot1.data.docs
              .map((docSnap) => UserRoles(docSnap.id, docSnap.data()['roles']))
              .toList();

          List<Widget> listTiles = [];
          for (var userRoles in userRolesList) {
            // 1つのpublicは複数のroleがある
            List<Widget> nameWidgets = [];
            for (var role in userRoles.roles) {
              nameWidgets.add(RoleToNameWidget(role));
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
        });
  }
}

class UserRoles {
  final id;
  final roles;
  UserRoles(this.id, this.roles);
}

var $family = StreamProvider.autoDispose.family;
var nameProvider = $family((ref, role) {
  return (role as DocumentReference).snapshots();
});

class RoleToNameWidget extends HookWidget {
  RoleToNameWidget(this.role);
  final role;
  @override
  Widget build(BuildContext context) {
    final nameAsync = useProvider(nameProvider(role));
    return nameAsync.when(
        data: (docSnap) {
          return Text(docSnap.data()['name']);
        },
        loading: () => Text("RoleToNameWidget Loading"),
        error: (o, s) => Text(o.toString()));
  }
}
