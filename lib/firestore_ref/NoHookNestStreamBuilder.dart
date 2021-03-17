import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/public.dart';

/**
 * StreamBuilderをnestして、FirebaseFirestoreを
 * Hookを使わないパターン
 */

/**
 * StreamBuilderを入れ子にしているが、
 * StreamBuilderがWidgetを返さないといけないため、
 * 内側のStreamBuilderはColumn(ListTile())を返している
 * 要するに、
 * ListView([
 *   Column([ListTile(),ListTile()]), Column([ListTile()])
 * ])
 * みたいな、構成になる。見た目にはわからないが。。。
 * ただこのままだと、並べ替えとかできない気がする
 */
class NoHookNestStreamBuilder extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('publics').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.hasError) return Text('Something went wrong');
        if (snapshot1.connectionState == ConnectionState.waiting)
          return Text("Loading");

        return ListView(children: [
          for (DocumentSnapshot pubDoc in snapshot1.data!.docs)
            StreamBuilder(
                stream: pubDoc.reference.collection('details').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot1.hasError) return Text('Something went wrong');

                  if (snapshot1.connectionState == ConnectionState.waiting ||
                      snapshot2.data == null) return Text("Loading");

                  // widgetを返さないといけない
                  return Column(
                      // ここがfor文みたいなもん
                      children: snapshot2.data!.docs.map((e) {
                    return ListTile(
                      title: Text(e.data()!['title']),
                      subtitle: Text(pubDoc.data()!['name']),
                    );
                  }).toList());
                })
        ]);
      },
    );
  }
}
