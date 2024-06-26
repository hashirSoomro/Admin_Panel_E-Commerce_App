// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get-all-users-length-contoller.dart';
import '../utils/app-constant.dart';
import '../models/user-model.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final GetUserLengthController _getUserLengthController =
      Get.put(GetUserLengthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
              'All Users (${_getUserLengthController.userCollectionLength.toString()})');
        }),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .orderBy('createdOn', descending: true)
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
              child: Text("No Users Found!"),
            );
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                UserModel userModel = UserModel(
                  uId: data['uId'],
                  username: data['username'],
                  email: data['email'],
                  phone: data['phone'],
                  userImg: data['userImg'],
                  userDeviceToken: data['userDeviceToken'],
                  country: data['country'],
                  userAddress: data['userAddress'],
                  street: data['street'],
                  isAdmin: data['isAdmin'],
                  isActive: data['isActive'],
                  createdOn: data['createdOn'],
                );

                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appSecondaryColor,
                      backgroundImage: CachedNetworkImageProvider(
                        userModel.userImg,
                        errorListener: (err) {
                          print("Error Lodaing Image");
                          Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(userModel.username),
                    subtitle: Text(userModel.email),
                    trailing: Icon(Icons.edit),
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
