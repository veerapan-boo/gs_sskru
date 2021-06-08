import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gs_sskru/bindings/operation_bindings.dart';
import 'package:gs_sskru/operation/operation.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load image
    precacheImage(AssetImage('assets/images/sskru_logo.png'), context);
    precacheImage(AssetImage('assets/images/pattern_new.png'), context);
    precacheImage(AssetImage('assets/images/education.png'), context);
    return GetMaterialApp(
      title: 'วิทยาลัยบัญฑิต | SSKRU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Prompt',
        canvasColor: Colors.white,
        accentColor: kPrimaryColor,
        primarySwatch: Colors.blue,
      ),
      initialRoute: Operation.routeName,
      initialBinding: OperationBindings(),
      getPages: [
        GetPage(
          name: Operation.routeName,
          page: () => Operation(),
        ),
      ],
    );
  }
}
