import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:path_provider/path_provider.dart';

final imageByUri = ScopedProvider<String>(null);

class ImageByUri extends StatelessWidget {
  const ImageByUri();
  @override
  Widget build(BuildContext context) {
    getApplicationDocumentsDirectory()
        .then((value) => context.read(_path).state = value.path);
    return const _Image();
  }
}

final _path = StateProvider<String>((_) => null);
final _image = StateProvider.family.autoDispose<File, String>((ref, uri) {
  final path = ref.watch(_path).state;
  if (path == null || uri == null || uri.isEmpty) return null;
  return File('$path/$uri');
});

class _Image extends ConsumerWidget {
  const _Image();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final image = watch(_image(watch(imageByUri))).state;
    if (image == null) {
      return Tooltip(
        message: '画像無し',
        child: Image.asset(
          'assets/coffee_icon.png',
          color: Theme.of(context).iconTheme.color,
        ),
      );
    }
    return GestureDetector(
      onLongPress: () {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => Center(child: Image.file(image)),
            fullscreenDialog: true,
          ),
        );
      },
      child: Image.file(
        image,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
