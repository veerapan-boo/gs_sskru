import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = kDefaultPadding * 25;

    bool isTablet = Responsive.isTablet(context);
    bool isDesktop = Responsive.isDesktop(context);
    bool isMobile = Responsive.isMobile(context);
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      height: isMobile ? height * .3 : height,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ข่าว',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
                  ),
                  Text(
                    'อยู่ระหว่างการพัฒนา...',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
