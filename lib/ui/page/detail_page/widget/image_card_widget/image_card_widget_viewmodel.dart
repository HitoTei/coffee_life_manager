import 'dart:developer';
import 'dart:io';

import 'package:coffee_life_manager/model/interface/image_card_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageCardWidgetViewModel {
  ImageCardWidgetViewModel({this.information});
  final ImageCardInformation information;

  // カメラで撮ってから取得して、ローカルに保存後そのファイルの名前を返す
  Future<File> fetchFromCamera() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    return fetchNewImageUri(pickedImage);
  }

  Future<File> fetchFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    return fetchNewImageUri(pickedImage);
  }

  Future<File> fetchNewImageUri(PickedFile file) async {
    final image = File(file.path);
    final path = (await getApplicationDocumentsDirectory()).path;
    final uri = information.getImageUri();
    final savePath = uri ?? DateTime.now().toString();

    information.setImageUri(savePath);
    log('save path: $path/$savePath');
    await image.copy('$path/$savePath');
    // 追加されるたびに画像のキャッシュをクリアするのはどうかと思う
    imageCache.clear();
    return image;
  }
}
