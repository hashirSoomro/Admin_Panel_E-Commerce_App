// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:admin_panel/controllers/products-images-controller.dart';
import 'package:admin_panel/models/categories-model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../services/generate-ids-service.dart';
import '../utils/app-constant.dart';

class AddCategoriesScreen extends StatefulWidget {
  AddCategoriesScreen({super.key});

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select Images"),
                    ElevatedButton(
                      onPressed: () {
                        addProductImagesController.showImagesPickerDialog();
                      },
                      child: const Text("Select Images"),
                    )
                  ],
                ),
              ),

              //show images
              GetBuilder<AddProductImagesController>(
                init: AddProductImagesController(),
                builder: (imageController) {
                  // ignore: prefer_is_empty
                  return imageController.selectedImages.length > 0
                      // ignore: sized_box_for_whitespace
                      ? Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: Get.height / 3,
                          child: GridView.builder(
                            itemCount: addProductImagesController
                                .selectedImages.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      child: const CircleAvatar(
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
                      : const SizedBox.shrink();
                },
              ),

              //form
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  cursorColor: AppConstant.appMainColor,
                  textInputAction: TextInputAction.next,
                  controller: categoryNameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    hintText: "Category Name",
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  EasyLoading.show();
                  await addProductImagesController.uploadFunction(
                      "Category", addProductImagesController.selectedImages);
                  String categoryId = await GenerateIds().generateCategoryId();

                  CategoryModel categoryModel = CategoryModel(
                    categoryId: categoryId,
                    categoryImg:
                        addProductImagesController.arrImagesUrl[0].toString(),
                    categoryName: categoryNameController.text.trim(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  FirebaseFirestore.instance
                      .collection('categories')
                      .doc(categoryId)
                      .set(categoryModel.toMap());

                  EasyLoading.dismiss();
                },
                child: Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
