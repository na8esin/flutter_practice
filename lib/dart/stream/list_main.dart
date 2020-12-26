// Copyright (c) 2015, the Dart project authors.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

Future<List<List<PublicDetail>>> sumStream(
    Stream<List<PublicDetail>> stream) async {
  List<List<PublicDetail>> sum = [];
  await for (var value in stream) {
    sum.add(value);
  }
  return sum;
}

Stream<List<PublicDetail>> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 1)
      yield [PublicDetail('john', 'title1'), PublicDetail('john', 'title2')];
    if (i == 2) yield [PublicDetail('mickel', 'title3')];
  }
}

main() async {
  Stream<List<PublicDetail>> stream = countStream(2);

  // Iterable<Future<List<PublicDetail>>> 本当は
  List<List<PublicDetail>> sum = await sumStream(stream);
  print(sum); // 55
}

class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}
