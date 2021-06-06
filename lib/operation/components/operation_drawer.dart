import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/navbar/navbar_menu.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';

class OperationDrawer extends StatelessWidget {
  final NavBarMenuController _navBarMenuController =
      Get.put(NavBarMenuController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              _navBarMenuController.getMenuItems.length,
              (index) => NavBarMenuItem(
                text: _navBarMenuController.getMenuItems[index],
                onPress: () => _navBarMenuController.setSelectedIndex(index),
                isActive: index == _navBarMenuController.getSelectedIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
