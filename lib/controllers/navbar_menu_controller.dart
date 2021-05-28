import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NavBarMenuController extends GetxController {
  RxInt _selectedIndex = 0.obs;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _menuItems = [
    'หน้าหลัก',
    'เกี่ยวกับบัญฑิต',
    'รับสมัครนักศึกษา',
    'หลักสูตร',
    'บริการ',
    'สำหรับเจ้าหน้าที่'
  ].obs;

  List<String> get getMenuItems => _menuItems;

  GlobalKey<ScaffoldState> get getScaffoldKey => _scaffoldKey;

  AnimateIconController _controllerAnimateIcons = AnimateIconController();

  int get getSelectedIndex => _selectedIndex.value;
  AnimateIconController get getControllerAnimateIcons =>
      _controllerAnimateIcons;

  void onDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setOnDrawerChanged(bool value) {
    if (value) {
      _controllerAnimateIcons.animateToEnd();
    } else {
      _controllerAnimateIcons.animateToStart();
    }
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void setMenuItemsOfAuthStatus(bool authStatus) {
    authStatus ? _menuItems[5] = '@Admin' : _menuItems[5] = 'สำหรับเจ้าหน้าที่';
  }
}
