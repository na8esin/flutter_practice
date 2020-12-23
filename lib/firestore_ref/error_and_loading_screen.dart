import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorScreen extends HookWidget {
  ErrorScreen(this.err);
  final Object err;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('$err'),
      ),
    );
  }
}

class LoadingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
