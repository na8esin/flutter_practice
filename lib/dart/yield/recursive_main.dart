// https://www.youtube.com/watch?v=TF-TBsgIErY
Iterable<int> getRange2(int start, int finish) sync* {
  if (start <= finish) {
    yield start;
    for (final val in getRange2(start + 1, finish)) {
      yield val;
    }
  }
}

Iterable<int> getRange3(int start, int finish) sync* {
  if (start <= finish) {
    yield start;
    yield* getRange3(start + 1, finish);
  }
}

void main(List<String> args) {
  final numbers2 = getRange2(1, 5);
  numbers2.forEach((e) => print(e));

  getRange3(1, 5).forEach((e) => print(e));
}
