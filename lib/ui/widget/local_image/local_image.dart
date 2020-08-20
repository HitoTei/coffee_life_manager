import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final file = Provider.of<File>(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      child: file != null
          ? Hero(
              tag: file,
              child: Image.file(
                file,
                fit: BoxFit.fitWidth, // or fitWidth
              ),
            )
          : const Center(
              child: Text('イメージ無し'),
            ),
    );
  }
}
