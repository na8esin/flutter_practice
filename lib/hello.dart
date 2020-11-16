import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice/error.dart';
import 'package:flutter_practice/loading.dart';

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference public = FirebaseFirestore.instance.collection('public');

    return  FutureBuilder<QuerySnapshot>(
        future: public.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Error();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          return MaterialApp(
            title: 'Welcome to Flutter',
            home: Scaffold(
              appBar: AppBar(
                title: Text('Hello'),
              ),
              body: Center(
                child: new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document.data()['name']),
                    subtitle: new Text(document.data()['subname']),
                  );
                }).toList(),)
              ),
            ),
          );
        },
    );
  }
}