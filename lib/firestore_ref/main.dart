import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'NoHookNestStreamBuilder.dart';
import 'NestStreamBuilderRoles.dart';
import 'NestStreamBuilderRolesHook.dart';
import 'StreamFamily.dart';
import 'OnePublicRoles.dart';
import 'CollectionGroupParent.dart';
import 'HookPubDetail.dart';
import 'HookPubDetailRef.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

List<Map<String, dynamic>> listListTile = [
  titleBuilder(NoHookNestStreamBuilder()),
  titleBuilder(NestStreamBuilderRoles()),
  titleBuilder(NestStreamBuilderRolesHook()),
  titleBuilder(StreamFamily()),
  titleBuilder(OnePublicRoles()),
  titleBuilder(CollectionGroupParent()),
  titleBuilder(HookPubDetail()),
  titleBuilder(HookPubDetailRef()),
];

titleBuilder(Widget clazz) {
  return {'title': Text(clazz.toStringShort()), 'builder': clazz};
}

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
