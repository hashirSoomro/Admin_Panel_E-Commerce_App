// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/products-images-controller.dart';
import '../utils/app-constant.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Images"),
                  ElevatedButton(
                    onPressed: () {
                      addProductImagesController.showImagesPickerDialog();
                    },
                    child: Text("Select Images"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
