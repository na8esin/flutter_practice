import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'public_provider_family.dart';

class PublicView extends HookWidget {
  const PublicView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useProvider(publicFamily('9qpBAhvsBfWsCp6iGREc')).when(
      loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
      error: (err, stack) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
        );
      },
      data: (public) {
        return Scaffold(
          appBar: AppBar(
            title: Text(public.name),
          ),
          body: Text(public.subname),
        );
      },
    );
  }
}
