import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/contents/home_content/components/box_news.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/models/title_link/title_link.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class NewsOthersContent extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());
  final double height = kDefaultPadding * 25;
  @override
  Widget build(BuildContext context) {
    final double kSizeWidth = Responsive.kSizeWidth(context);
    final double contentWidth =
        (kSizeWidth < kMaxWidth ? kSizeWidth / 2 : kMaxWidth / 2) -
            kDefaultPadding;

    List<Widget> _listWidgetDesktop = [
      // Can see the type at data_type.dart
      Obx(
        () => BoxNews(
          contentWidth: contentWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[1].text,
          type: 1,
          data: _newsController.getListTypeOneOnly,
        ),
      ),
      SizedBox(width: kDefaultPadding),
      Obx(
        () => BoxNews(
          contentWidth: contentWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[0].text,
          type: 0,
          data: _newsController.getListTypeZeroOnly,
        ),
      )
    ];

    List<Widget> _listWidgetTablet = [
      // Can see the type at data_type.dart
      Obx(
        () => BoxNews(
          contentWidth: kSizeWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[1].text,
          type: 1,
          data: _newsController.getListTypeOneOnly,
        ),
      ),
      SizedBox(height: kDefaultPadding),
      Obx(
        () => BoxNews(
          contentWidth: kSizeWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[0].text,
          type: 0,
          data: _newsController.getListTypeZeroOnly,
        ),
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2),
      width: kMaxWidth < kSizeWidth ? kMaxWidth : kSizeWidth,
      child: Responsive(
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listWidgetDesktop,
        ),
        tablet: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: _listWidgetTablet,
          ),
        ),
        mobile: Column(
          children: _listWidgetTablet,
        ),
      ),
    );
  }
}
