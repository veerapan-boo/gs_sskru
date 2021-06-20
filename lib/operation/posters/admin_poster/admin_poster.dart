import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/navbar/navbar.dart';
import 'package:gs_sskru/operation/posters/admin_poster/components/content_admin_poster.dart';
import 'package:gs_sskru/operation/posters/admin_poster/components/content_login.dart';
import 'package:gs_sskru/util/constants.dart';

class AdminPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container desktop = Container(
      height: context.height - NavBar().navBarHeight,
      padding: EdgeInsets.only(bottom: NavBar().navBarHeight),
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContentAdminPoster(),
          ContentLogin(),
        ],
      ),
    );

    Container tablet = Container(
      height: context.height - NavBar().navBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContentAdminPoster(),
          ContentLogin(),
        ],
      ),
    );

    return context.responsiveValue(
      desktop: desktop,
      tablet: tablet,
      mobile: tablet,
    )!;
  }
}
