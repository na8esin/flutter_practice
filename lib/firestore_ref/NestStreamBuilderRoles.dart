import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NestStreamBuilderRoles extends HookWidget {
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
        });
  }
}

class UserRoles {
  final id;
  final roles;
  UserRoles(this.id, this.roles);
}
