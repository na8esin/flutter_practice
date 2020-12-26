import 'dart:async';

// https://www.youtube.com/watch?v=nQBpOIHE4eE
class NumberCreator {
  NumberCreator() {
    Timer.periodic(Duration(seconds: 2), (t) {
      _controller.sink.add(_count);
      _count++;
    });
  }

  var _count = 1;
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;
}

void main(List<String> args) {
  NumberCreator().stream.listen((count) {
    print(count);
  });
}
