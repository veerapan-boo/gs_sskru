import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/home_poster_title_header.dart';
import 'package:gs_sskru/util/constants.dart';

class HomePoster extends StatelessWidget {
  final ImageProvider _imagePoster = AssetImage(
    'assets/images/sskru_poster1.jpg',
  );
  @override
  Widget build(BuildContext context) {
    final double height = kDefaultPadding * 30;

    return Container(
      height: context.responsiveValue(
        desktop: height,
        tablet: height * .75,
        mobile: height * .75,
      ),
      // constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Stack(
        children: [
          if (!context.isPhone)
            Positioned(
              right: 0,
              child: Container(
                width: context.responsiveValue(
                    desktop: context.width, tablet: 440, mobile: 0),
                height: context.responsiveValue(
                  desktop: height,
                  tablet: height * .75,
                  mobile: height * .75,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagePoster,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            left: context.responsiveValue(
              desktop: kDefaultPadding * 4,
              tablet: kDefaultPadding,
              mobile: 0,
            ),
            child: Align(
              alignment: context.responsiveValue(
                  desktop: Alignment.centerLeft,
                  tablet: Alignment.centerLeft,
                  mobile: Alignment.center)!,
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
