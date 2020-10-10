import 'dart:io';

import 'package:coffee_life_manager/function/files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final imageByUri = ScopedProvider<String>(null);

class ImageByUri extends ConsumerWidget {
  const ImageByUri();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final uri = watch(imageByUri);
    final image = getLocalFile(uri);

    return FutureBuilder(
      future: image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text('None'),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'エラー ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          );
        }
        final file = snapshot.data;
        return ProviderScope(
          overrides: [_image.overrideWithValue(file)],
          child: const _Image(),
        );
      },
    );
  }
}

final _image = ScopedProvider<File>((_) => null);

class _Image extends ConsumerWidget {
  const _Image();
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    return Image.file(
      watch(_image),
      fit: BoxFit.fitWidth,
    );
  }
}
