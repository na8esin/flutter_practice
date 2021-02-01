import 'package:flutter/material.dart';

// https://note.com/iwatsuru/n/nb646c5e6b62b

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Align(alignment: Alignment.topCenter, child: Bubble('ふきだしです')),
            Align(alignment: Alignment.centerLeft, child: Bubble('ふきだしです')),
            Align(alignment: Alignment.centerRight, child: Bubble('ふきだしです')),
            Align(alignment: Alignment.bottomCenter, child: Bubble('ふきだしです')),
          ],
        )),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final String text;

  Bubble(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.green[200],
        shadows: [
          const BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          )
        ],
        shape: BubbleBorder(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
        ],
      ),
    );
  }
}

class BubbleBorder extends ShapeBorder {
  final bool usePadding;

  const BubbleBorder({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 12 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final r =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 12));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(r, Radius.circular(8)))
      ..moveTo(r.bottomCenter.dx - 10, r.bottomCenter.dy)
      ..relativeLineTo(10, 12)
      ..relativeLineTo(10, -12)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
