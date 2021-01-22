import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'details_last.dart';
import 'details_last2.dart';
import 'NoHookNestStreamBuilder.dart';
import 'NestStreamBuilderRoles.dart';
import 'NestStreamBody.dart';
import 'NestStreamBuilderRolesHook.dart';
import 'StreamFamily.dart';
import 'OnePublicRoles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

List<Map<String, dynamic>> listListTile = [
  {
    'title': Text(NestStreamBody().toStringShort()),
    'builder': NestStreamBody()
  },
  {'title': Text(DetailsLast().toStringShort()), 'builder': DetailsLast()},
  {
    'title': Text(DetailsLast2ListViewSeparated().toStringShort()),
    'builder': DetailsLast2ListViewSeparated()
  },
  {
    'title': Text(DetailsLast2Listview().toStringShort()),
    'builder': DetailsLast2Listview()
  },
  {
    'title': Text(NoHookNestStreamBuilder().toStringShort()),
    'builder': NoHookNestStreamBuilder()
  },
  {
    'title': Text(NestStreamBuilderRoles().toStringShort()),
    'builder': NestStreamBuilderRoles()
  },
  {
    'title': Text(NestStreamBuilderRolesHook().toStringShort()),
    'builder': NestStreamBuilderRolesHook()
  },
  {'title': Text(StreamFamily().toStringShort()), 'builder': StreamFamily()},
  {
    'title': Text(OnePublicRoles().toStringShort()),
    'builder': OnePublicRoles()
  },
];

class MyApp extends HookWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemCount: listListTile.length,
            separatorBuilder: (context, index) => const SizedBox(height: 3),
            itemBuilder: (context, index) {
              return ListTile(
                  title: listListTile[index]['title'],
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                body: listListTile[index]['builder'],
                              ))));
            }));
  }
}
