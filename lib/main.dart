import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gs_sskru/screens/home_screen/home_screen.dart';
import 'package:gs_sskru/util/constants.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'วิทยาลัยบัญฑิต | SSKRU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Prompt',
        canvasColor: Colors.white,
        accentColor: kPrimaryColor,
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
