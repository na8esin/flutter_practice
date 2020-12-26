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

List<Map<String, dynamic>> listListTile = [
  {'title': Text(PublicsBody().toStringShort()), 'builder': PublicsBody()},
  {
    'title': Text(DetailsGroupBody().toStringShort()),
    'builder': DetailsGroupBody()
  }
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

final publicsProvider = StreamProvider.autoDispose((ref) {
  // await しても変わんない
  //Stream<List<PublicDoc>> awaitPubStream = await PublicsRef().documents();

  return PublicsRef().documents();
});

final $family = StreamProvider.autoDispose.family;
final detailsProvider = $family<QuerySnapshot, String>((ref, id) {
  CollectionReference public = FirebaseFirestore.instance.collection('publics');
  DocumentReference detailsDoc = public.doc(id);
  CollectionReference details = detailsDoc.collection('details');
  return details.snapshots();
});

final detailsRefProvider = $family<QuerySnapshot, PublicDoc>((ref, publicDoc) {
  DocumentReference docref = publicDoc.publicRef.ref;
  return docref.collection('details').snapshots();
});

final detailsRef2Provider =
    $family<List<DetailDoc>, PublicDoc>((ref, publicDoc) {
  return DetailsRef(publicDoc: publicDoc).documents();
});

// 単純にCollectionGroupを使う
final detailsGroupProvider = StreamProvider.autoDispose((ref) {
  return DetailsGroupRef().documents();
});

class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}

class PublicsBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<PublicDoc>> asyncValue = useProvider(publicsProvider);
    return asyncValue.when(
        data: (data) {
          return ListView.separated(
            itemCount: data.length,
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
                          // FirebaseFirestoreをそのまま使うパターン
                          // body: DetailScreen(data.elementAt(index).id),
                          // ちょっとだけ、firestore_refを使うバージョン
                          // body: DetailRefScreen(data.elementAt(index)),
                          // firestore_refだけにはなってるが、DetailsRefを書き換えたバージョン
                          body: DetailRef2Screen(data.elementAt(index)));
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

class DetailsGroupBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<DetailDoc>> asyncValue = useProvider(detailsGroupProvider);
    return asyncValue.when(
        data: (data) {
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              Detail entity = data.elementAt(index).entity;
              return ListTile(
                title: Text(entity.title),
                // TODO: ここはむしろ親のnameとかが欲しい
//                subtitle: Text(entity.subname),
                onTap: () {},
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

class DetailRef2Screen extends HookWidget {
  DetailRef2Screen(this.publicDoc);
  final PublicDoc publicDoc;
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<DetailDoc>> asyncValue =
        useProvider(detailsRef2Provider(publicDoc));
    return asyncValue.when(
        data: (List<DetailDoc> data) {
          return DetailDocListView(itemCount: data.length, details: data);
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

class DetailDocListView extends HookWidget {
  DetailDocListView({this.itemCount, this.details});
  final int itemCount;
  final List<DetailDoc> details;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        Detail entity = details.elementAt(index).entity;
        return ListTile(
          title: Text(entity.title),
          subtitle: Text(entity.title),
          onTap: () {},
        );
      },
    );
  }
}
