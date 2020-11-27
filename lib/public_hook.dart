import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CharacterView extends HookWidget {
  const CharacterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = useProvider(selectedCharacterId);
    assert(
      id != null,
      'CharacterView used but selectedCharacterId is null',
    );

    return useProvider(character(id)).when(
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
      data: (character) {
        return Scaffold(
          appBar: AppBar(
            title: Text(character.name),
          ),
          body: LoadingImage(url: character.thumbnail.url),
        );
      },
    );
  }
}
