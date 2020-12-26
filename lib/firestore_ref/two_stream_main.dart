import 'package:async/async.dart';

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
  {
    'title': Text(SubColleDetailsGroupBody().toStringShort()),
    'builder': SubColleDetailsGroupBody()
  },
  {'title': Text(NestStreamBody().toStringShort()), 'builder': NestStreamBody()}
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

// 単純にCollectionGroupを使う
final detailsGroupProvider = StreamProvider.autoDispose((ref) {
  return DetailsGroupRef().documents();
});

// 親のコレクションとCollectionGroupをくっつける
// 本当はin句みたいなのに入れるのか？でも10個までだって。
// detailsが1つ更新になったら、全部のpublicを取得するのか？
// CollectionGroupだと結びつける手段がないか。。
/*final detailsGroupProvider = StreamProvider.autoDispose((ref) async {
  List<DetailDoc> details = await DetailsGroupRef().documents().last;
  List<PublicDoc> publics = await PublicsRef().documents().last;
  details.map((e) => {
    e.detailRef.
  });
});*/

// 実直にpublicsからdetailsを引っ張る
final publicsDetailsProvider = FutureProvider.autoDispose((ref) async {
  List<PublicDoc> publics = await ref.watch(publicsProvider.last);

  List<Future<List<PublicDetail>>> re = publics.map((PublicDoc doc) async {
    // ここをwatchにすると絶え間なく画面がロードされる
    // Future.wait()はコメントアウトしてても。
    // とりあえずで返してる値も断続的に表示される
    //QuerySnapshot snapshots = await ref.watch(detailsRefProvider(doc).last);
    var hoge = ref.watch(detailsRefProvider(doc).last);
  }).toList();

  // ここで止まる
  // await Future.wait(re)

  return foldList([
    [
      PublicDetail('publicName', 'detailtitle'),
      PublicDetail('publicName', 'detailtitle2')
    ],
    [PublicDetail('publicName', 'detailtitle3')]
  ]);

  // とりあえずの返却値
  //return [PublicDetail('publicName', 'detailtitle')];
});

// ぐるぐるが終わらない
final publicsDetails2Provider = FutureProvider.autoDispose((ref) async {
  List<PublicDoc> publics = await ref.watch(publicsProvider.last);

  var snaps = publics.map((PublicDoc public) async {
    var aa = await FirebaseFirestore.instance
        .collection('publics')
        .doc(public.id)
        .collection('details')
        .snapshots()
        .last;

    List<PublicDetail> bb = aa.docs.map<PublicDetail>(
        (e) => PublicDetail(public.entity.name, e.data()['title']));
    return bb;
  }).toList();
  var cc = Future.wait(snaps);
  return cc;
});

/**
 * [[PublicDetail,PublicDetail],[PublicDetail]] 
 *  => [PublicDetail,PublicDetail,PublicDetail]
 */
List<PublicDetail> foldList(List<List<PublicDetail>> lists) {
  return lists.fold<List<PublicDetail>>([],
      (List<PublicDetail> previousValue, List<PublicDetail> element) {
    previousValue.addAll(element.map((e) => e));
    return previousValue;
  });
}

// モデル
class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}

// DetailsGroupBodyで親のフィールドが欲しいところを改良したバージョン
class SubColleDetailsGroupBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<List<PublicDetail>>> asyncValue =
        useProvider(publicsDetails2Provider);
    return asyncValue.when(
        data: (data) {
          var foldData = foldList(data);
          return ListView.separated(
            itemCount: foldData.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              PublicDetail entity = foldData.elementAt(index);
              return ListTile(
                title: Text(entity.detailtitle),
                subtitle: Text(entity.publicName),
                onTap: () {},
              );
            },
          );
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}

class NestStreamBody extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<PublicDoc>> asyncValue = useProvider(publicsProvider);
    return asyncValue.when(
        data: (List<PublicDoc> data) {
          //String publicName = data.elementAt(index).entity.name;
          //return NestedStreamBody(data.elementAt(index), publicName);
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}

class NestedStreamBody extends HookWidget {
  NestedStreamBody(this.publicDoc, this.publicName);
  final PublicDoc publicDoc;
  final String publicName;
  @override
  Widget build(BuildContext context) {
    AsyncValue<QuerySnapshot> asyncDetail =
        useProvider(detailsRefProvider(publicDoc));

    return asyncDetail.when(
        data: (QuerySnapshot data2) {
          return ListView.separated(
              itemCount: data2.docs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index2) {
                return ListTile(
                  title: Text(data2.docs.elementAt(index2).data()['title']),
                  subtitle: Text(publicName),
                  onTap: () {},
                );
              });
        },
        error: (err, stack) => ErrorScreen(err),
        loading: () => LoadingScreen());
  }
}
