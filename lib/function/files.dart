import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile(String fileName) async {
  if (fileName == null || fileName.isEmpty) return null;
  final path = (await getApplicationDocumentsDirectory()).path;
  return File('$path/$fileName');
}

Future<void> deleteFile(String imageUri) async {
  if (imageUri != null) {
    try {
      (await getLocalFile(imageUri)).deleteSync();
    } catch (e) {
      log('Catch exception when deleting image: $e');
    }
  }
}
