import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  Error({this.error});
  final Object? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
