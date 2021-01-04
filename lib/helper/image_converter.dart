import 'dart:io';

import 'package:image_native_resizer/image_native_resizer.dart';

class ImageConverter {
  Future<File> compressProductSmallImage(String path) async {
    final String resizedPath = await ImageNativeResizer.resize(
      imagePath: path,
      maxWidth: 200,
      maxHeight: 600,
      quality: 50,
    );
    return File(resizedPath);
  }

  Future<File> compressProductBigImage(String path) async {
    final String resizedPath = await ImageNativeResizer.resize(
      imagePath: path,
      maxWidth: 1024,
      maxHeight: 1024,
      quality: 80,
    );
    return File(resizedPath);
  }
}
