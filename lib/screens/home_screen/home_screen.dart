import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/footer/footer.dart';
import 'package:gs_sskru/components/navbar/navbar.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/screens/home_screen/components/home_drawer.dart';
import 'package:gs_sskru/screens/home_screen/components/switch_content.dart';
import 'package:gs_sskru/screens/home_screen/components/switch_poster.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';

class HomeScreen extends StatelessWidget {
  final NavBarMenuController _navBarMenuController =
      Get.put(NavBarMenuController());
  final FirebaseAuthServiceController _firebaseAuthService =
      Get.put(FirebaseAuthServiceController());

  final CustomScrollView _customScrollView = CustomScrollView(
    slivers: [
      NavBar(),
      SwitchPoster(),
      SwitchContent(),
      Footer(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _navBarMenuController.getScaffoldKey,
      onDrawerChanged: (value) {
        _navBarMenuController.setOnDrawerChanged(value);
      },
      drawer: HomeDrawer(),
      body: StreamBuilder<User?>(
        stream: _firebaseAuthService.authStateChanges(),
        builder: (_, snap) {
          return _customScrollView;
        },
      ),
    );
  }
}
