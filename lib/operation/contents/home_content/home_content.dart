import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/operation/contents/home_content/components/education_join_up_news_content.dart';
import 'package:gs_sskru/operation/contents/home_content/components/news_others_content.dart';
import 'package:gs_sskru/util/constants.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // * Education join up news content
        EducationJoinUp(),
        // SizedBox(
        //   height: context.responsiveValue(
        //     desktop: kDefaultPadding * 4,
        //     tablet: kDefaultPadding * 2,
        //     mobile: kDefaultPadding,
        //   ),
        // ),
        // * Research fund news content
        NewsOthersContent(),
      ],
    );
  }
}
