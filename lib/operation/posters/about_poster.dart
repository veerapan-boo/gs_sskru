import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class AboutPoster extends StatelessWidget {
  final ImageProvider _imagePosterThree = AssetImage(
    'assets/images/sskru_poster2.jpg',
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultPadding * 20,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagePosterThree,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'เกี่ยวกับบัญฑิต',
                      style: context
                          .responsiveValue(
                              desktop: context.textTheme.headline2,
                              tablet: context.textTheme.headline2,
                              mobile: context.textTheme.headline4)!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
