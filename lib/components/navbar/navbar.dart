import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/navbar/navbar_menu.dart';
import 'package:gs_sskru/components/navbar/navbar_title.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class NavBar extends GetView<NavBarMenuController> {
  get navBarHeight => 100.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      expandedHeight: navBarHeight,
      collapsedHeight: navBarHeight,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              padding: EdgeInsets.all(kDefaultPadding),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NavBarTitle(),
                    Spacer(),
                    if (Responsive.isDesktop(context)) NavBarMenu(),
                    if (!Responsive.isDesktop(context))
                      AnimateIcons(
                        startIcon: Icons.drag_handle,
                        endIcon: Icons.close_sharp,
                        controller: controller.getControllerAnimateIcons,
                        duration: Duration(milliseconds: 190),
                        size: 25.0,
                        startIconColor: Colors.black38,
                        endIconColor: Colors.black38,
                        clockwise: false,
                        onEndIconPress: () => true,
                        onStartIconPress: () {
                          controller.onDrawer();
                          return true;
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
