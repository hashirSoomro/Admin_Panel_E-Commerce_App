// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/order-model.dart';
import '../utils/app-constant.dart';
import 'check-single-order-screen.dart';

class SpecificCustomerOrderScreen extends StatelessWidget {
  String docId;
  String customerName;
  SpecificCustomerOrderScreen({
    super.key,
    required this.docId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(customerName),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(docId)
            .collection('confirmOrders')
            .orderBy('createdAt', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Orders Found!"),
            );
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                String orderDocId = data.id;
                OrderModel orderModel = OrderModel(
                  productId: data['productId'],
                  categoryId: data['categoryId'],
                  productName: data['productName'],
                  categoryName: data['categoryName'],
                  salePrice: data['salePrice'],
                  fullPrice: data['fullPrice'],
                  productImages: data['productImages'],
                  deliveryTime: data['deliveryTime'],
                  isSale: data['isSale'],
                  productDescription: data['productDescription'],
                  createdAt: data['createdAt'],
                  updatedAt: data['updatedAt'],
                  productQuantity: data['productQuantity'],
                  productTotalPrice: data['productTotalPrice'],
                  customerId: data['customerId'],
                  status: data['status'],
                  customerName: data['customerName'],
                  customerPhone: data['customerPhone'],
                  customerAddress: data['customerAddress'],
                  customerDeviceToken: data['customerDeviceToken'],
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        () => CheckSingleOrderScreen(
                          docId: snapshot.data!.docs[index].id,
                          orderModel: orderModel,
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      child: Text(data['customerName'][0]),
                    ),
                    title: Text(data['customerName']),
                    subtitle: Text(data['productName']),
                    trailing: InkWell(
                      onTap: () {
                        showBottomSheet(
                          userDocId: docId,
                          orderModel: orderModel,
                          orderDocID: orderDocId,
                        );
                      },
                      child: Icon(Icons.more_vert),
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

  void showBottomSheet({
    required String userDocId,
    required OrderModel orderModel,
    required String orderDocID,
  }) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(userDocId)
                          .collection('confirmOrders')
                          .doc(orderDocID)
                          .update({
                        'status': false,
                      });
                    },
                    child: Text("Pending")),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(userDocId)
                          .collection('confirmOrders')
                          .doc(orderDocID)
                          .update({
                        'status': true,
                      });
                    },
                    child: Text("Delivered"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
