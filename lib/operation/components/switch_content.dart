import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/operation/contents/about_content.dart';
import 'package:gs_sskru/operation/contents/course_content.dart';
import 'package:gs_sskru/operation/contents/home_content/home_content.dart';
import 'package:gs_sskru/operation/contents/service_content.dart';

class SwitchContent extends StatefulWidget {
  const SwitchContent({Key? key}) : super(key: key);
  @override
  _SwitchContentState createState() => _SwitchContentState();
}

class _SwitchContentState extends State<SwitchContent>
    with TickerProviderStateMixin {
  SharedAxisTransitionType? _transitionType = SharedAxisTransitionType.vertical;

  final List<Widget> _listContents = [
    HomeContent(),
    AboutContent(),
    SizedBox(),
    CourseContent(),
    ServiceContent(),
    SizedBox()
  ];
  final _navBarMenuController = Get.find<NavBarMenuController>();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Obx(
            () => AnimatedSize(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300),
              vsync: this,
              child: PageTransitionSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: _transitionType!,
                    child: child,
                  );
                },
                child: _listContents[_navBarMenuController.getSelectedIndex],
              ),
            ),
          )
        ],
      ),
    );
  }
}
