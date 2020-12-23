import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'public.dart';
import 'detail.dart';

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
  CollectionReference details = public.doc(id).collection('details');
  return details.snapshots();
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
                        body: DetailScreen(data.elementAt(index).id),
                      );
                    }),
                  );
                },
              );
            },
          );
        },
        error: (err, stack) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('$err'),
            ),
          );
        },
        loading: () => Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ));
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
          List<Detail> details =
              data.docs.map((e) => Detail(title: e.data()['title'])).toList();
          return ListView.separated(
            itemCount: data.docs.length,
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
        },
        error: (err, stack) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('$err'),
            ),
          );
        },
        loading: () => Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ));
  }
}
