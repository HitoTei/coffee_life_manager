import 'dart:developer';
import 'dart:io';

import 'package:coffee_life_manager/function/get_file.dart';
import 'package:coffee_life_manager/ui/widget/local_image/local_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Dart:async';
import 'image_card_widget_viewmodel.dart';

class ChangeableImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ImageCardWidgetViewModel>(context);
    final image = ValueNotifier<File>(null);
    getLocalFile(viewModel.information.getImageUri())
        .then((value) => image.value = value);

    return FlatButton(
      color: Colors.black12,
      onPressed: () async {
        final file = await showImagePickerDialog(context, viewModel);
        if (file != null) {
          image.value = file;
          log('file fetched. file: $file');
        }
      },

      // ToDo: FIX.途中で購読がされなくなる？
      child: ValueListenableProvider<File>(
        create: (_) => image,
        child: LocalImage(),
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
