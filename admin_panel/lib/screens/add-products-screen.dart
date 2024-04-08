// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category-dropdown-controller.dart';
import '../controllers/products-images-controller.dart';
import '../utils/app-constant.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  CategoryDropDownController categoryDropDownController =
      Get.put(CategoryDropDownController());

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
            ),
            //show images
            GetBuilder<AddProductImagesController>(
              init: AddProductImagesController(),
              builder: (imageController) {
                return imageController.selectedImages.length > 0
                    ? Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: Get.height / 3,
                        child: GridView.builder(
                          itemCount:
                              addProductImagesController.selectedImages.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Stack(
                              children: [
                                Image.file(
                                  File(imageController
                                      .selectedImages[index].path
                                      .toString()),
                                  fit: BoxFit.cover,
                                  height: Get.height / 4,
                                  width: Get.width / 2,
                                ),
                                Positioned(
                                  right: 10,
                                  top: 0,
                                  child: InkWell(
                                    onTap: () {
                                      imageController.removeImages(index);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppConstant.appSecondaryColor,
                                      child: Icon(
                                        Icons.close,
                                        color: AppConstant.appTextColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
