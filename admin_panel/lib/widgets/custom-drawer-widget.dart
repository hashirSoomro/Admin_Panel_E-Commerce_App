// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:admin_panel/screens/all-users-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/app-constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        backgroundColor: AppConstant.appSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Hashir",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                subtitle: Text(
                  "Version 1.0.1",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppConstant.appMainColor,
                  child: Text("H"),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Home",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  leading: Icon(Icons.home, color: AppConstant.appTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                  onTap: () {
                    Get.to(() => AllUsersScreen());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Users",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  leading: Icon(Icons.person, color: AppConstant.appTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Orders",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  leading: Icon(Icons.shopping_bag,
                      color: AppConstant.appTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Products",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  leading: Icon(Icons.shop, color: AppConstant.appTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Categories",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(Icons.category, color: AppConstant.appTextColor),
                onTap: () {
                  // Get.back();
                  // Get.to(() => AllOrdersScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Contact",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  leading: Icon(Icons.help, color: AppConstant.appTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                  onTap: () async {
                    // GoogleSignIn googleSignIn = GoogleSignIn();
                    // FirebaseAuth _auth = FirebaseAuth.instance;

                    // await _auth.signOut();
                    // await googleSignIn.signOut();
                    // Get.offAll(() => WelcomeScreen());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Log Out",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  leading: Icon(Icons.logout, color: AppConstant.appTextColor)),
            ),
          ],
        ),
      ),
    );
  }
}
