import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/get_size.dart';
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // * Title
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleHeader extends StatefulWidget {
  const TitleHeader({
    Key? key,
  }) : super(key: key);

  @override
  _TitleHeaderState createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader> {
  double _sizeWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    Color white = Colors.white;
    var text = context.textTheme.apply(
      bodyColor: white,
      displayColor: white,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetSize(
          onChange: (size) {
            setState(() {
              _sizeWidth = size.width;
            });
          },
          child: Text(
            'สำนักงานบัณฑิตศึกษา',
            style: context.textTheme.headline2,
          ),
        ),
        if (_sizeWidth != 0.0)
          Container(
            width: _sizeWidth - 7,
            color: kPrimaryColor,
            child: Center(
              child: Text(
                'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                style: context.responsiveValue(
                  desktop: text.headline4,
                  tablet: text.subtitle1,
                  mobile: text.subtitle1,
                ),
              ),
            ),
          )
      ],
    );
  }
}
