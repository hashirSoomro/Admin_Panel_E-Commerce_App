// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, await_only_futures, unused_local_variable

import 'dart:io';

import 'package:admin_panel/controllers/is-sale-controller.dart';
import 'package:admin_panel/services/generate-ids-service.dart';
import 'package:admin_panel/widgets/dropdown-categories-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  IsSaleController isSaleController = Get.put(IsSaleController());

  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
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
            ),
            // Show categories dropdown
            DropDownCategoriesWidget(),

            //isSale
            GetBuilder<IsSaleController>(
              init: IsSaleController(),
              builder: (IsSaleController) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Is Sale"),
                        Switch(
                          value: isSaleController.isSale.value,
                          activeColor: AppConstant.appMainColor,
                          onChanged: (value) {
                            isSaleController.toggleIsSale(value);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

            //form
            SizedBox(
              height: 10,
            ),
            Container(
              height: 65,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                cursorColor: AppConstant.appMainColor,
                textInputAction: TextInputAction.next,
                controller: productNameController,
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
            SizedBox(
              height: 10,
            ),
            // Obx(() {
            //   return isSaleController.isSale.value
            //       ? Container(
            //           height: 65,
            //           margin: EdgeInsets.symmetric(horizontal: 10),
            //           child: TextFormField(
            //             cursorColor: AppConstant.appMainColor,
            //             textInputAction: TextInputAction.next,
            //             controller: salePriceController,
            //             decoration: InputDecoration(
            //               contentPadding: EdgeInsets.symmetric(
            //                 horizontal: 10,
            //               ),
            //               hintText: "Sale Price",
            //               hintStyle: TextStyle(
            //                 fontSize: 12,
            //               ),
            //               border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(
            //                     10,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         )
            //       : SizedBox.shrink();
            // }),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: 65,
            //   margin: EdgeInsets.symmetric(horizontal: 10),
            //   child: TextFormField(
            //     cursorColor: AppConstant.appMainColor,
            //     textInputAction: TextInputAction.next,
            //     controller: fullPriceController,
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(
            //         horizontal: 10,
            //       ),
            //       hintText: "Full Price",
            //       hintStyle: TextStyle(
            //         fontSize: 12,
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(
            //             10,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: 65,
            //   margin: EdgeInsets.symmetric(horizontal: 10),
            //   child: TextFormField(
            //     cursorColor: AppConstant.appMainColor,
            //     textInputAction: TextInputAction.next,
            //     controller: deliveryTimeController,
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(
            //         horizontal: 10,
            //       ),
            //       hintText: "Delivery Time",
            //       hintStyle: TextStyle(
            //         fontSize: 12,
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(
            //             10,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: 65,
            //   margin: EdgeInsets.symmetric(horizontal: 10),
            //   child: TextFormField(
            //     cursorColor: AppConstant.appMainColor,
            //     textInputAction: TextInputAction.next,
            //     controller: productDescriptionController,
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(
            //         horizontal: 10,
            //       ),
            //       hintText: "Product Description",
            //       hintStyle: TextStyle(
            //         fontSize: 12,
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(
            //             10,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async {
                //String productId = await GenerateIds().generateProductId();
                //print(productId);
                try {
                  EasyLoading.show();
                  await addProductImagesController.uploadFunction(
                      addProductImagesController.selectedImages);
                  print(addProductImagesController.arrImagesUrl);
                  EasyLoading.dismiss();
                } catch (e) {
                  print("error: $e");
                }
              },
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
