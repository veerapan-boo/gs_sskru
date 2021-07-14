import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gs_sskru/bindings/operation_bindings.dart';
import 'package:gs_sskru/operation/operation.dart';
import 'package:gs_sskru/theme.dart';
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
    loadImage(context);
    return GetMaterialApp(
      title: 'สำนักงานบัณฑิตศึกษา',
      debugShowCheckedModeBanner: false,
      builder: themeBuilder,
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

  // Load image from first re-rander
  loadImage(context) {
    precacheImage(AssetImage('assets/images/sskru_logo.png'), context);
    precacheImage(AssetImage('assets/images/pattern_new.png'), context);
    precacheImage(AssetImage('assets/images/zone-content-bg-new.png'), context);
    precacheImage(AssetImage('assets/images/sskru_poster1.jpg'), context);
    precacheImage(AssetImage('assets/images/sskru_poster2.jpg'), context);
    precacheImage(AssetImage('assets/images/sskru_poster3.jpg'), context);
    precacheImage(AssetImage('assets/images/sskru_poster4.jpg'), context);
    precacheImage(AssetImage('assets/images/book1.png'), context);
    precacheImage(AssetImage('assets/images/book2.png'), context);
    precacheImage(AssetImage('assets/images/student_cap1.png'), context);
    precacheImage(AssetImage('assets/images/student_cap2.png'), context);
  }
}
