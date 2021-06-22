import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/contact_desktop.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/contact_mobile.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/contact_tablet.dart';

class HomePostContect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.responsiveValue(
      desktop: ContactDesktop(),
      tablet: ContactTablet(),
      mobile: ContactMobile(),
    )!;
  }
}
