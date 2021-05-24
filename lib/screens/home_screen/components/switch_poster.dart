import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/screens/home_screen/posters/about_poster.dart';
import 'package:gs_sskru/screens/home_screen/posters/admin_poster.dart';
import 'package:gs_sskru/screens/home_screen/posters/admission_poster.dart';
import 'package:gs_sskru/screens/home_screen/posters/course_poster.dart';
import 'package:gs_sskru/screens/home_screen/posters/home_poster.dart';
import 'package:gs_sskru/screens/home_screen/posters/service_poster.dart';
import 'package:gs_sskru/util/constants.dart';

class SwitchPoster extends StatefulWidget {
  @override
  _SwitchPosterState createState() => _SwitchPosterState();
}

class _SwitchPosterState extends State<SwitchPoster>
    with SingleTickerProviderStateMixin {
  final List<Widget> _listPosters = [
    HomePoster(),
    AboutPoster(),
    AdmissionPoster(),
    CoursePoster(),
    ServicePoster(),
    AdminPoster(),
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
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: _listPosters[_navBarMenuController.getSelectedIndex],
              ),
            ),
          )
        ],
      ),
    );
  }
}
