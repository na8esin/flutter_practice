import 'dart:async';

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;

  // await forは完了するストリームと一緒に使用する
  // https://www.youtube.com/watch?v=SmTCmDMi4BY
  // 完了しないストリームって何だろう。。。
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}
