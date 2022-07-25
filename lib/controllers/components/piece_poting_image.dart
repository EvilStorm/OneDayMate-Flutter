import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odm/constants/key_store.dart';
import 'package:odm/utils/print.dart';

class PostionImagePiece {
  final storage = GetStorage();
  final FirebaseStorage fstorage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  RxList<String> images = <String>[].obs;
  List<String> imageUrl = [];

  final int maxImageCount = 5;

  void addIamge() async {
    if (images.length >= maxImageCount) {
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images.add(image.path);
    }
  }

  Future<bool> postingImages() async {
    for (var image in images) {
      String? result = await fileUpload(image);
      if (result != null) {
        imageUrl.add(result);
      }
    }
    return true;
  }

  Future<String?> fileUpload(String path) async {
    try {
      String uploadFileName =
          '${storage.read(KeyStore.userID_I)}_${DateTime.now().millisecondsSinceEpoch}';

      Reference ref = fstorage.ref().child('images/$uploadFileName');
      await ref.putFile(File(path));
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      Print.e(e);
      return null;
    }
  }

  void removeImage(int index) async {
    images.removeAt(index);
  }
}
