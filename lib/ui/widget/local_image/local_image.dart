import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final file = Provider.of<File>(context);
    log('image build');

    return Container(
      constraints: const BoxConstraints.expand(),
      child: file != null
          ? Image.file(
              file,
              fit: BoxFit.fill, // or fitWidth
            )
          : const Center(
              child: Text('イメージ無し'),
            ),
    );
  }
}