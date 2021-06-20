import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/home_poster_title_header.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class HomePoster extends StatelessWidget {
  final ImageProvider _imagePoster = AssetImage(
    'assets/images/pattern_new.png',
  );
  @override
  Widget build(BuildContext context) {
    final double height = kDefaultPadding * 25;

    bool isTablet = Responsive.isTablet(context);
    bool isDesktop = Responsive.isDesktop(context);
    bool isMobile = Responsive.isMobile(context);

    return Container(
      height: context.responsiveValue(
        desktop: height,
        tablet: height,
        mobile: height * .75,
      ),
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Stack(
        children: [
          if (!isMobile)
            Positioned(
              right: 0,
              child: Container(
                width: 500,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _imagePoster,
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: Align(
              alignment: isDesktop || isTablet
                  ? Alignment.centerLeft
                  : Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // * Title
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TitleHeader(),
                                ],
                              ),
                              // SizedBox(
                              //   height: context.responsiveValue(
                              //     desktop: kDefaultPadding,
                              //     tablet: kDefaultPadding * .75,
                              //     mobile: kDefaultPadding * .5,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
