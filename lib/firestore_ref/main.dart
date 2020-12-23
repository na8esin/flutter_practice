import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'public.dart';
import 'detail.dart';
import 'error_and_loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

class MyApp extends HookWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBody(),
    );
  }
}

final publicsProvider = StreamProvider.autoDispose((ref) {
  return PublicsRef().documents();
});

final $family = StreamProvider.autoDispose.family;
final detailsProvider = $family<QuerySnapshot, String>((ref, id) {
  CollectionReference public = FirebaseFirestore.instance.collection('publics');
  DocumentReference detailsDoc = public.doc(id);
  CollectionReference details = detailsDoc.collection('details');
  return details.snapshots();
});

final detailsRefProvider =
    $family<QuerySnapshot, PublicDoc>((ref, publicDocdoc) {
  return publicDocdoc.publicRef.ref.collection('details').snapshots();
});

class MyBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<PublicDoc>> asyncValue = useProvider(publicsProvider);
    return asyncValue.when(
        data: (data) {
          return ListView.separated(
            itemCount: data.length,
            padding: EdgeInsetsDirectional.only(
              start: 120,
              end: 60,
              top: 28,
              bottom: kToolbarHeight,
            ),
            primary: false,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              Public entity = data.elementAt(index).entity;
              return ListTile(
                title: Text(entity.name),
                subtitle: Text(entity.subname),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('details')),
                        // body: DetailScreen(data.elementAt(index).id),
                        // ちょっとだけ、firestore_refを使ったバージョン
                        body: DetailRefScreen(data.elementAt(index)),
                      );
                    }),
                  );
                },
              );
            },
          );
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}

class DetailScreen extends HookWidget {
  DetailScreen(this.id);
  final String id;
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue = useProvider(detailsProvider(id));
    return asyncValue.when(
        data: (data) {
          // TODO: この、オブジェクトマッピングのコードをなくしたい
          List<Detail> details =
              data.docs.map((e) => Detail(title: e.data()['title'])).toList();
          return DetailListView(itemCount: data.docs.length, details: details);
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}

class DetailRefScreen extends HookWidget {
  DetailRefScreen(this.publicDoc);
  final PublicDoc publicDoc;
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncValue =
        useProvider(detailsRefProvider(publicDoc));
    return asyncValue.when(
        data: (data) {
          // TODO: この、オブジェクトマッピングのコードをなくしたい
          List<Detail> details =
              data.docs.map((e) => Detail(title: e.data()['title'])).toList();
          return DetailListView(itemCount: data.docs.length, details: details);
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}

class DetailListView extends HookWidget {
  DetailListView({this.itemCount, this.details});
  final int itemCount;
  final List<Detail> details;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      padding: EdgeInsetsDirectional.only(
        start: 120,
        end: 60,
        top: 28,
        bottom: kToolbarHeight,
      ),
      primary: false,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        Detail entity = details.elementAt(index);
        return ListTile(
          title: Text(entity.title),
          subtitle: Text(entity.title),
          onTap: () {},
        );
      },
    );
  }
}
