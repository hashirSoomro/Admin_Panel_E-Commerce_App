import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app-constant.dart';

class AddProductImagesController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> arrImagesUrl = <String>[].obs;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  Future<void> showImagesPickerDialog() async {
    PermissionStatus status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    if (androidDeviceInfo.version.sdkInt <= 32) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }

    if (status == PermissionStatus.granted) {
      Get.defaultDialog(
        title: "Choose Image",
        middleText: "Pick an Image from the camera or gallery",
        actions: [
          ElevatedButton(
            onPressed: () {
              selectImages('camera');
            },
            child: Text("Camera"),
          ),
          ElevatedButton(
            onPressed: () {
              selectImages('gallery');
            },
            child: Text("Gallery"),
          ),
        ],
      );
    }
    if (status == PermissionStatus.denied) {
      Get.snackbar(
          "Warning", "Please Allow Storage Permission to add an product image",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondaryColor,
          colorText: AppConstant.appTextColor);
      openAppSettings();
    }
    if (status == PermissionStatus.permanentlyDenied) {
      Get.snackbar(
          "Warning", "Please Allow Storage Permission to add an product image",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondaryColor,
          colorText: AppConstant.appTextColor);
    }
  }

  Future<void> selectImages(String type) async {
    List<XFile> imgs = [];
    if (type == 'gallery') {
      try {
        imgs = await _picker.pickMultiImage(imageQuality: 80);
        update();
      } catch (e) {
        print('Error $e');
      }
    } else {
      final img =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      if (img != null) {
        imgs.add(img);
        update();
      }
    }
    if (imgs.isNotEmpty) {
      selectedImages.addAll(imgs);
      update();
    }
  }

  void removeImages(int index) {
    selectedImages.removeAt(index);
    update();
  }

  Future<void> uploadFunction(String InfoImage, List<XFile> _images) async {
    arrImagesUrl.clear();
    for (int i = 0; i < _images.length; i++) {
      dynamic imageUrl = await uploadFile(InfoImage, _images[i]);
      arrImagesUrl.add(imageUrl.toString());
    }
    update();
  }

  Future<String?> uploadFile(String InfoImage, XFile _image) async {
    TaskSnapshot? reference = null;
    if (InfoImage == 'Category') {
      print("Category");
      reference = await storageRef
          .ref()
          .child("category-images")
          .child(_image.name + DateTime.now().toString())
          .putFile(File(_image.path));
    } else if (InfoImage == 'Product') {
      print("Product");
      reference = await storageRef
          .ref()
          .child("product-images")
          .child(_image.name + DateTime.now().toString())
          .putFile(File(_image.path));
    }
    return await reference!.ref.getDownloadURL();
  }
}
