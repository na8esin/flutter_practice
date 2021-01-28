import 'package:flutter/material.dart';

class BrokenRenderBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          children: [Text('hello')],
        )
      ],
    );
  }
}
