import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final publicProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance.collection('publics').snapshots().map(
      (e) => e.docs.map((e) => UserRoles(e.id, e.data()['roles'])).toList());
});

final rolesProvider = StateProvider.autoDispose((ref) {
  var asyncValue = ref.watch(publicProvider);
  return asyncValue.whenData(
    (userRolesList) {
      List<UserNamesAsync> userNamesList = [];
      for (var userRoles in userRolesList) {
        List<AsyncValue<String>> names = [];
        for (var role in userRoles.roles) {
          // ここはストリーム
          var roleAsync =
              ref.watch(nameProvider((role as DocumentReference).id));
          // whenDataで解決を延期してるっぽい
          var name = roleAsync.whenData(
            (data) => data,
          );
          names.add(name);
        }
        userNamesList.add(UserNamesAsync(userRoles.id, names));
      }
      return userNamesList;
    },
  );
});

final $family = StreamProvider.autoDispose.family;
final nameProvider = $family<String, String>((ref, String id) {
  return FirebaseFirestore.instance
      .collection('roles')
      .doc(id)
      .snapshots()
      .map((event) => event.data()['name']);
});

class NestStreamBuilderRolesHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var state = useProvider(rolesProvider).state;
    return state.when(
        data: (data) {
          return ListView(
              children: data
                  .map((e) => ListTile(
                        title: Text(e.id),
                        subtitle: Column(
                          children: e.names
                              .map((AsyncValue<String> e) => Text(e.when(
                                  data: (data) => data,
                                  loading: () => 'loading',
                                  error: (o, s) => o.toString())))
                              .toList(),
                        ),
                      ))
                  .toList());
        },
        loading: () => Text('loading'),
        error: (o, s) => Text(o.toString()));
  }
}

class UserRoles {
  final id;
  final roles;
  UserRoles(this.id, this.roles);
}

class UserNames {
  final String id;
  final List<String> names;
  UserNames(this.id, this.names);
}

class UserNamesAsync {
  final String id;
  final List<AsyncValue<String>> names;
  UserNamesAsync(this.id, this.names);
}
