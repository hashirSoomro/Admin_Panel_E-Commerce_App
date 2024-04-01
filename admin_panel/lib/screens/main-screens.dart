// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

import '../utils/app-constant.dart';
import '../widgets/custom-drawer-widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Admin Panel"),
      ),
      drawer: DrawerWidget(),
    );
  }
}
