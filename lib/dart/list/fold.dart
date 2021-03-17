void main(List<String> args) {
  final iterable = [1, 3, 5];
  int ret = iterable.fold(0, (prev, element) => prev + element);
  assert(ret == 9);
  print(ret);

  List<List<int>> iterable2 = [
    [1, 3],
    [5]
  ];
  var ret2 = iterable2.fold<List<int>>([], (List<int> previousValue, element) {
    previousValue.addAll(element.map((e) => e));
    return previousValue;
  });
  // TODO: なんかいまいちな比較方法
  // ↓こんな方法もある
  // https://stackoverflow.com/questions/10404516/how-can-i-compare-lists-for-equality-in-dart
  assert(ret2.toString() == [1, 3, 5].toString());
  print(ret2);
}
