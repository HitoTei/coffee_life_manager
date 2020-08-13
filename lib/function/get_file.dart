import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile(String fileName) async {
  if (fileName == null) return null;
  final path = (await getApplicationDocumentsDirectory()).path;
  return File('$path/$fileName');
}
