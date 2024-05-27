// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:admin_panel/models/categories-model.dart';
import 'package:admin_panel/screens/add-categories-screen.dart';
import 'package:admin_panel/screens/edit-categories-screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../controllers/edit_category_controller.dart';
import '../utils/app-constant.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => AddCategoriesScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
        backgroundColor: AppConstant.appMainColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('categories')
            // .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Categories Found!"),
            );
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                CategoryModel categoryModel = CategoryModel(
                  categoryId: data['categoryId'],
                  categoryImg: data['categoryImg'],
                  categoryName: data['categoryName'],
                  createdAt: data['createdAt'],
                  updatedAt: data['updatedAt'],
                );

                return SwipeActionCell(
                  key: ObjectKey(categoryModel.categoryId),

                  /// this key is necessary
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                        title: "Delete",
                        onTap: (CompletionHandler handler) async {
                          await Get.defaultDialog(
                            title: "Delete Product",
                            content: const Text(
                                "Are you sure you want to delete this product?"),
                            textCancel: "Cancel",
                            textConfirm: "Delete",
                            contentPadding: const EdgeInsets.all(10.0),
                            confirmTextColor: Colors.white,
                            onCancel: () {},
                            onConfirm: () async {
                              Get.back();
                              EasyLoading.show(status: "Please wait...");
                              EditCategoryController editCategoryController =
                                  Get.put(EditCategoryController(
                                      categoryModel: categoryModel));

                              await editCategoryController
                                  .deleteImageFromFirestore(
                                      categoryModel.categoryImg,
                                      categoryModel.categoryId);
                              await editCategoryController
                                  .deleteWholeCategoryFromFirestore(
                                      categoryModel.categoryImg,
                                      categoryModel.categoryId);
                              // await deleteImagesFromFirebase(
                              //     productModel.productImages);

                              // await FirebaseFirestore.instance
                              //     .collection('products')
                              //     .doc(productModel.productId)
                              //     .delete();
                              EasyLoading.dismiss();
                            },
                            buttonColor: Colors.red,
                            cancelTextColor: Colors.black,
                          );
                        },
                        color: Colors.red),
                  ],
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appSecondaryColor,
                        backgroundImage: CachedNetworkImageProvider(
                          categoryModel.categoryImg.toString(),
                          errorListener: (err) {
                            print("Error Loading Image");
                            Icon(Icons.error);
                          },
                        ),
                      ),
                      title: Text(categoryModel.categoryName),
                      subtitle: Text(categoryModel.categoryId),
                      trailing: GestureDetector(
                        onTap: () => Get.to(
                          () =>
                              EditCategoryScreen(categoryModel: categoryModel),
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
