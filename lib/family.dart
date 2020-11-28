import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'public.dart';

final $family = FutureProvider.autoDispose.family;
final publicFamily = $family<Public, String>((ref, documentId) async {
  // このあたりがrepository化した方がいい？
  CollectionReference users = FirebaseFirestore.instance.collection('public');
  Map<String, dynamic> data = (await users.doc(documentId).get()).data();
  return Public(name: data['name'], subname: data['subname']);
//  return dio.get('http://my_api.dev/messages/$id');
});
