import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/contents/about_content.dart';
import 'package:gs_sskru/contents/admission_content.dart';
import 'package:gs_sskru/contents/course_content.dart';
import 'package:gs_sskru/contents/home_content/home_content.dart';
import 'package:gs_sskru/contents/service_content.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';

class SwitchContent extends StatefulWidget {
  @override
  _SwitchContentState createState() => _SwitchContentState();
}

class _SwitchContentState extends State<SwitchContent>
    with SingleTickerProviderStateMixin {
  SharedAxisTransitionType? _transitionType = SharedAxisTransitionType.vertical;
  final List<Widget> _listContents = [
    HomeContent(),
    AboutContent(),
    AdmissionContent(),
    CourseContent(),
    ServiceContent(),
    SizedBox()
  ];

  final NavBarMenuController _navBarMenuController =
      Get.put(NavBarMenuController());

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Obx(
            () => AnimatedSize(
              curve: Curves.easeOutQuart,
              duration: Duration(milliseconds: 1000),
              vsync: this,
              child: PageTransitionSwitcher(
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
