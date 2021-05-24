import 'package:flutter/material.dart';
import 'package:gs_sskru/components/navbar/navbar.dart';
import 'package:gs_sskru/posters/admin_poster/components/content_admin_poster.dart';
import 'package:gs_sskru/posters/admin_poster/components/content_login.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class AdminPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return isDesktop
        ? Container(
            height: Responsive.kSizeHeight(context) - NavBar().navBarHeight * 2,
            constraints: BoxConstraints(maxWidth: kMaxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ContentAdminPoster(),
                ContentLogin(),
              ],
            ),
          )
        : Container(
            height: Responsive.kSizeHeight(context),
            child: Column(
              mainAxisAlignment: isDesktop
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ContentAdminPoster(),
                ContentLogin(),
              ],
            ),
          );
  }
}
