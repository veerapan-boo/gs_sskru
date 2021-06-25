import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/get_size.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/operation/contents/home_content/components/box_news.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class NewsOthersContent extends StatelessWidget {
  final ImageProvider _imagePosterThree = AssetImage(
    'assets/images/sskru_poster3.jpg',
  );
  final ImageProvider _imagePosterFour = AssetImage(
    'assets/images/sskru_poster4.jpg',
  );
  final double height = kDefaultPadding * 25;
  final double imageMinHeight = 500.0;

  final _newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    final double kSizeWidth = Responsive.kSizeWidth(context);
    final double contentWidth =
        (kSizeWidth < kMaxWidth ? kSizeWidth / 2 : kMaxWidth / 2) -
            kDefaultPadding;
    List<Widget> _listWidgetDesktop = [
      // Can see the type at data_type.dart
      // * ข่าวประกาศ
      ValueBuilder<double>(
        initialValue: imageMinHeight,
        builder: (double? heightValue, Function(double)? updateheightValue) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Obx(
                  () {
                    return GetSize(
                      onChange: (size) {
                        if (size.height > imageMinHeight)
                          updateheightValue!(size.height);
                      },
                      child: BoxNews(
                        contentWidth: contentWidth,
                        title:
                            TitleLinkModel().getValue.data![0].subTitle[1].text,
                        type: 1,
                        data: _newsController.getListTypeOneOnly,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: heightValue,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagePosterThree,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // * ข่าวทุนวิจัย
      ValueBuilder<double>(
        initialValue: imageMinHeight,
        builder: (double? heightValue, Function(double)? updateheightValue) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: heightValue,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagePosterFour,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Obx(
                    () => GetSize(
                      onChange: (size) {
                        if (size.height > imageMinHeight)
                          updateheightValue!(size.height);
                      },
                      child: BoxNews(
                        contentWidth: contentWidth,
                        title:
                            TitleLinkModel().getValue.data![0].subTitle[0].text,
                        type: 0,
                        data: _newsController.getListTypeZeroOnly,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ];

    List<Widget> _listWidgetTablet = [
      // Can see the type at data_type.dart
      Obx(
        () => BoxNews(
          contentWidth: context.width,
          title: TitleLinkModel().getValue.data![0].subTitle[1].text,
          type: 1,
          data: _newsController.getListTypeOneOnly,
        ),
      ),
      SizedBox(height: kDefaultPadding),
      Obx(
        () => BoxNews(
          contentWidth: context.width,
          title: TitleLinkModel().getValue.data![0].subTitle[0].text,
          type: 0,
          data: _newsController.getListTypeZeroOnly,
        ),
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 6),
      width: kMaxWidth < kSizeWidth ? kMaxWidth : kSizeWidth,
      child: Responsive(
        desktop: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listWidgetDesktop,
        ),
        tablet: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listWidgetDesktop,
        ),
        mobile: Column(
          children: _listWidgetTablet,
        ),
      ),
    );
  }
}
