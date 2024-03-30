// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/order-model.dart';
import '../utils/app-constant.dart';

class CheckSingleOrderScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;
  CheckSingleOrderScreen({
    super.key,
    required this.docId,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(orderModel.productImages[0]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Product Details:",
              style: TextStyle(
                fontSize: Get.height / 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productTotalPrice.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("x" + orderModel.productQuantity.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.productDescription),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Customer Details:",
              style: TextStyle(
                fontSize: Get.height / 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerPhone),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(orderModel.customerAddress),
          ),
        ],
      ),
    );
  }
}
