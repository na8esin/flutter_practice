// https://www.youtube.com/watch?v=TF-TBsgIErY

Iterable<int> getRange(int start, int finish) sync* {
  for (int i = start; i <= finish; i++) {
    yield i;
  }
}

void main(List<String> args) {
  final numbers = getRange(1, 9);
  for (int val in numbers) print(val);

  final list = numbers.map((e) => e * 2).toList();
  print(list);
}
