import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/footer/footer.dart';
import 'package:gs_sskru/components/k_progress.dart';
import 'package:gs_sskru/components/navbar/navbar.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/operation/components/operation_drawer.dart';
import 'package:gs_sskru/operation/components/switch_poster.dart';

import 'components/switch_content.dart';

class Operation extends GetWidget<NavBarMenuController> {
  static String routeName = '/operation';

  final FirebaseAuthServiceController _firebaseAuthService =
      Get.put(FirebaseAuthServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.getScaffoldKey,
      onDrawerChanged: (value) {
        controller.setOnDrawerChanged(value);
      },
      drawer: OperationDrawer(),
      body: StreamBuilder<User?>(
        stream: _firebaseAuthService.authStateChanges(),
        builder: (_, __) {
          return FetchNewsData();
        },
      ),
    );
  }
}

class FetchNewsData extends Operation {
  final NewsController _newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    CustomScrollView _customScrollView = CustomScrollView(
      controller: controller.getScrollController,
      slivers: [
        NavBar(),
        SwitchPoster(),
        SwitchContent(),
        Footer(),
      ],
    );
    return FutureBuilder(
      future: _newsController.fetchNewsData(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return _customScrollView;
        }
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'กรุณารอสักครู่',
                style: TextStyle(color: Colors.black87.withOpacity(.65)),
              ),
              SizedBox(width: 15),
              SizedBox(child: KProgress(), width: 18, height: 18)
            ],
          ),
        );
      },
    );
  }
}
