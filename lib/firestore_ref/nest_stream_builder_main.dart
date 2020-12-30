import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/**
 * NoHookNestStreamBuilder
 * の苦しまぎれのColumnを消したいのに頑張ったが、未完成
 */
class Body extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('publics').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.hasError) return Text('Something went wrong');
        if (snapshot1.connectionState == ConnectionState.waiting)
          return Text("Loading");

        var aaa = ListView(children: [
          for (DocumentSnapshot document in snapshot1.data.docs)
            StreamBuilder(
                stream: document.reference.collection('details').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot1.hasError) return Text('Something went wrong');

                  if (snapshot1.connectionState == ConnectionState.waiting ||
                      snapshot2.data == null) return Text("Loading");

                  var bbb = snapshot2.data.docs.map((e) {
                    return ListTile(
                      title: Text(e.data()['title']),
                      subtitle: Text(document.data()['name']),
                    );
                  }).toList();
                  // TODO: とりあえず
                  return Container();
                })
        ]);
      },
    );
  }
}
