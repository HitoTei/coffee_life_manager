import 'dart:developer';
import 'dart:io';

import 'package:coffee_life_manager/ui/widget/image_card_widget/image_card_widget_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Dart:async';

class ChangeableImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ImageCardWidgetViewModel>(context);
    final image = ValueNotifier<File>(null);
    viewModel.getLocalFile().then((value) => image.value = value);

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(height: 120), // TODO: 調整する
      child: FlatButton(
        color: Colors.black12,
        onPressed: () async {
          final file = await showImagePickerDialog(context, viewModel);
          if (file != null) {
            image.value = file;
          }
        },
        child: ValueListenableProvider<File>(
          create: (_) => image,
          child: _Image(),
        ),
      ),
    );
  }

  Future<File> showImagePickerDialog(
      BuildContext context, ImageCardWidgetViewModel viewModel) {
    return showDialog<File>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('画像を選択'),
          children: <Widget>[
            // コンテンツ領域
            SimpleDialogOption(
              onPressed: () async {
                final file = await viewModel.fetchFromCamera();
                Navigator.pop(context, file);
              },
              child: const Text('カメラで写真を撮る'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final file = await viewModel.fetchFromGallery();
                Navigator.pop(context, file);
              },
              child: const Text('フォルダから選択'),
            ),
          ],
        );
      },
    );
  }
}

class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final file = Provider.of<File>(context);
    log('image build');

    return file != null
        ? Image.file(file)
        : const Center(child: Text('イメージ無し'));
  }
}
