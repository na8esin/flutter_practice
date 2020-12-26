import 'package:async/async.dart';

Future<int> fetchDouble(int val) {
  return Future.delayed(Duration(seconds: 1), () => val * 2);
}

Stream<int> fetchDoubles(int start, int finish) async* {
  if (start <= finish) {
    yield await fetchDouble(start);
    yield* fetchDoubles(start + 1, finish);
  }
}

void main(List<String> args) {
//  fetchDoubles(1, 10).listen(print);
  // ただ、交互に出力されるだけ
  StreamGroup.merge([fetchDoubles(1, 5), fetchDoubles(6, 10)]).listen(print);
}
