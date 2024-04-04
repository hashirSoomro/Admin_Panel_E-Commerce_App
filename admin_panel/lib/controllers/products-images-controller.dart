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
          ElevatedButton(onPressed: () {}, child: Text("Camera")),
          ElevatedButton(onPressed: () {}, child: Text("Gallery")),
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
}
