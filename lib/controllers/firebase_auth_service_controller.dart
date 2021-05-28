import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';

class FirebaseAuthServiceController extends GetxController {
  final NavBarMenuController _navBarMenuController =
      Get.put(NavBarMenuController());
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  bool isAuthenticated = false;

  User get user => _user!;

  Future<User?> signInWithEmailAndPassword(
      String userEmail, String userPassword) async {
    return _user = await _firebaseAuth
        .signInWithEmailAndPassword(email: userEmail, password: userPassword)
        .then((userCredential) => userCredential.user);
  }

  Stream<User?> authStateChanges() {
    Stream<User?> _authStateChanges = _firebaseAuth.authStateChanges();

    _authStateChanges.listen((event) {
      if (event != null) {
        _user = event;
        isAuthenticated = true;
        update();
        _navBarMenuController.setMenuItemsOfAuthStatus(true);
        print('Authentication status: Already logged in !');
      } else {
        _user = null;
        isAuthenticated = false;
        _navBarMenuController.setMenuItemsOfAuthStatus(false);
        update();
        print('Authentication status: Logged out !');
      }
    });
    return _authStateChanges;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
