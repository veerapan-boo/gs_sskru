import 'package:flutter/material.dart';
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
      height: isMobile ? height * .3 : height,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'สำนักงานบัณฑิตศึกษา',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: isDesktop
                                ? 55
                                : isTablet
                                    ? 40
                                    : 30),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: kMaxWidth),
                        color: kPrimaryColor,
                        width: isDesktop
                            ? 505
                            : isTablet
                                ? 367
                                : 277,
                        child: Center(
                          child: Text(
                            'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: isMobile ? 20 : 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
