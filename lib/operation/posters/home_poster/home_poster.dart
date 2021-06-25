import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/home_poster_title_header.dart';
import 'package:gs_sskru/util/constants.dart';

class HomePoster extends StatelessWidget {
  // final ImageProvider _imagePoster = AssetImage(
  //   'assets/images/sskru_poster1.jpg',
  // );
  final ImageProvider _imagePoster = AssetImage(
    'assets/images/zone-content-bg-new.png',
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
                  desktop: context.width,
                  tablet: context.width,
                  mobile: 0,
                ),
                height: context.responsiveValue(
                  desktop: height,
                  tablet: height,
                  mobile: height,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagePoster,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          // Positioned(
          //   child: Container(
          //     height: height,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           kPrimaryColor.withOpacity(0.0),
          //           kPrimaryColor.withOpacity(.95),
          //         ],
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //       ),
          //     ),
          //   ),
          // ),
          // * Title
          Positioned.fill(
            bottom: context.responsiveValue(
              desktop: kDefaultPadding * 4,
              tablet: kDefaultPadding,
              mobile: 0,
            ),
            child: Align(
              alignment: context.responsiveValue(
                desktop: Alignment.bottomCenter,
                tablet: Alignment.center,
                mobile: Alignment.center,
              )!,
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
