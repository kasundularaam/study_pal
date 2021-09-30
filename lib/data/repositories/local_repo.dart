import 'dart:io';

import 'package:image_picker/image_picker.dart';

class LocalRepo {
  static ImagePicker picker = ImagePicker();
  static Future<File> pickImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 300, maxHeight: 300);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw "No image selected";
    }
  }
}
