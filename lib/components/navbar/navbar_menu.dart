import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/util/constants.dart';

class NavBarMenu extends StatelessWidget {
  final NavBarMenuController _navBarMenuController =
      Get.put(NavBarMenuController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          _navBarMenuController.getMenuItems.length,
          (index) => NavBarMenuItem(
            text: _navBarMenuController.getMenuItems[index],
            onPress: () => _navBarMenuController.setSelectedIndex(index),
            isActive: index == _navBarMenuController.getSelectedIndex,
          ),
        ),
      ),
    );
  }
}

class NavBarMenuItem extends StatelessWidget {
  const NavBarMenuItem({
    Key? key,
    required this.isActive,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 2, color: isActive ? kPrimaryColor : Colors.transparent),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: isActive ? FontWeight.normal : FontWeight.w300),
        ),
      ),
    );
  }
}
