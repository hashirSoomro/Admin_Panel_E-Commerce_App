// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/controllers/edit_category_controller.dart';
import 'package:admin_panel/models/categories-model.dart';
import 'package:admin_panel/utils/app-constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatefulWidget {
  CategoryModel categoryModel;
  EditCategoryScreen({
    super.key,
    required this.categoryModel,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryNameController.text = widget.categoryModel.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(widget.categoryModel.categoryName),
      ),
      body: Container(
        child: Column(
          children: [
            GetBuilder(
              init: EditCategoryController(categoryModel: widget.categoryModel),
              builder: (editCategory) {
                return editCategory.categoryImg.value != ''
                    ? Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: editCategory.categoryImg.value.toString(),
                            fit: BoxFit.contain,
                            height: Get.height / 5.5,
                            width: Get.width / 2,
                            placeholder: ((context, url) => Center(
                                  child: CupertinoActivityIndicator(),
                                )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Positioned(
                            right: 10,
                            top: 0,
                            child: InkWell(
                              onTap: () async {
                                EasyLoading.show();
                                await editCategory.deleteImagesFromStorage(
                                    editCategory.categoryImg.value.toString());
                                await editCategory.deleteImageFromFirestore(
                                    editCategory.categoryImg.value.toString(),
                                    widget.categoryModel.categoryId);
                                EasyLoading.dismiss();
                              },
                              child: CircleAvatar(
                                backgroundColor: AppConstant.appSecondaryColor,
                                child: Icon(
                                  Icons.close,
                                  color: AppConstant.appTextColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : SizedBox.shrink();
              },
            ),

            //form widget
            SizedBox(
              height: 10,
            ),
            Container(
              height: 65,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: categoryNameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  hintText: "Product Name",
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
                CategoryModel categoryModel = CategoryModel(
                    categoryId: widget.categoryModel.categoryId,
                    categoryImg: widget.categoryModel.categoryImg,
                    categoryName: categoryNameController.text.trim(),
                    createdAt: widget.categoryModel.createdAt,
                    updatedAt: DateTime.now());
                await FirebaseFirestore.instance
                    .collection('categories')
                    .doc(categoryModel.categoryId)
                    .update(categoryModel.toMap());
                EasyLoading.dismiss();
              },
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
