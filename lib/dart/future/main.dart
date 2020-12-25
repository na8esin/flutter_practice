void main() async {
  List<Future<bool>> futureList = [];
  for (int i = 0; i < 5; i++) {
    futureList.add(somethingAPI(i));
  }

  print('Future.wait() start');
  Future<List<bool>> futureWait = Future.wait(futureList);

  print('start await');
  List<bool> result = await futureWait;
  print(result);
  print('print end');
}

Future<bool> somethingAPI(int t) async {
  print(t.toString() + ' start');
  Future<bool> future =
      Future.delayed(Duration(seconds: t), () => t % 2 == 0 ? true : false);

  bool value = await future;
  print(t.toString() + ' end');
  return value;
}
