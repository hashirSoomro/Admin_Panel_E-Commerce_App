import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/categories-model.dart';

class EditCategoryController extends GetxController {
  CategoryModel categoryModel;
  EditCategoryController({required this.categoryModel});
  Rx<String> categoryImg = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getRealTimeCategoryImages();
  }

  void getRealTimeCategoryImages() {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryModel.categoryId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['categoryImg'] != null) {
          categoryImg.value = data['categoryImg'].toString();
          update();
        }
      }
    });
  }

  //delete images
  Future deleteImagesFromStorage(String imageUrl) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    try {
      Reference reference = storage.refFromURL(imageUrl);
      await reference.delete();
    } catch (e) {
      print("Error:$e");
    }
  }

  //collection
  Future<void> deleteImageFromFirestore(
      String imageUrl, String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .update({'categoryImg': ''});
      update();
    } catch (e) {
      print("Error:$e");
    }
  }

  Future<void> deleteWholeCategoryFromFirestore(
      String imageUrl, String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
      update();
    } catch (e) {
      print("Error:$e");
    }
  }
}
