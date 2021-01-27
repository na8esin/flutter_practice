import 'package:flutter/material.dart';

class ListViewHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('header'),
        SizedBox(
          height: 50,
        ),
        Expanded(
          child: ListView(
            children: [
              Text('one'),
              Text('two'),
              Text('three'),
            ],
          ),
        )
      ],
    );
  }
}
