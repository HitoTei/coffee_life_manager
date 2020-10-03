import 'dart:io';

import 'package:coffee_life_manager/function/files.dart';
import 'package:flutter/material.dart';

class ImageByUri extends StatelessWidget {
  const ImageByUri(this.uri);
  final String uri;
  @override
  Widget build(BuildContext context) {
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
        return Image.file(
          file,
          fit: BoxFit.fitWidth,
        );
      },
    );
  }
}
