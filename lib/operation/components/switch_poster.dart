import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/operation/posters/about_poster.dart';
import 'package:gs_sskru/operation/posters/admin_poster/admin_poster.dart';
import 'package:gs_sskru/operation/posters/admission_poster.dart';
import 'package:gs_sskru/operation/posters/course_poster/course_poster.dart';
import 'package:gs_sskru/operation/posters/home_poster/home_poster.dart';
import 'package:gs_sskru/operation/posters/service_poster.dart';

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
                reverse: false,
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
          ),
        ],
      ),
    );
  }
}
