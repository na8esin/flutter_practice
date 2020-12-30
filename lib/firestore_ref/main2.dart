import 'package:async/async.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/public.dart';
import 'details_last.dart';
import 'details_last2.dart';
import 'NoHookNestStreamBuilder.dart';
import 'error_and_loading_screen.dart';

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
    'title': Text(NoHookNestStreamBuilder().toStringShort()),
    'builder': NoHookNestStreamBuilder()
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

final publicsProvider = StreamProvider<List<PublicDoc>>((ref) {
  return PublicsRef().documents();
});

final $family = StreamProvider.autoDispose.family;
final detailsRefProvider = $family<QuerySnapshot, PublicDoc>((ref, publicDoc) {
  DocumentReference docref = publicDoc.publicRef.ref;
  return docref.collection('details').snapshots();
});

// ぐるぐる止まらないけどね。
final combineProvider = FutureProvider<Map<int, NameTitles>>((ref) async {
  List<PublicDoc> public = await ref.watch(publicsProvider.last);
  NameFuture f = public.fold<NameFuture>(NameFuture([], []),
      (NameFuture previousValue, PublicDoc e) {
    // futureはいったん解決させない
    Future<QuerySnapshot> d =
        e.publicRef.ref.collection('details').snapshots().last;
    previousValue.name.add(e.entity.name);
    previousValue.d.add(d);
    return previousValue;
  });
  List<QuerySnapshot> aa = await Future.wait(f.d);
  var bbb = aa.asMap().map((key, QuerySnapshot value) {
    String name = f.name[key];
    List<String> titles = value.docs.map((e) => e.data()['title']);
    return MapEntry(key, NameTitles(name, titles));
  });
  return bbb;
});

class NameTitles {
  NameTitles(this.name, this.titles);
  final String name;
  final List<String> titles;
}

class NameFuture {
  NameFuture(this.name, this.d);
  final List<String> name;
  final List<Future<QuerySnapshot>> d;
}

// モデル
class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}

class NestStreamBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<Map<int, NameTitles>> asyncValue = useProvider(combineProvider);
    return asyncValue.when(
        data: (data) {
          return ListView(
            children: [
              for (var value in data.entries)
                for (var value2 in value.value.titles)
                  ListTile(
                    title: Text(value2),
                    subtitle: Text(value.value.name),
                  )
            ],
          );
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}
