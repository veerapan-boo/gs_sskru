import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class EducationJoinUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      margin: EdgeInsets.symmetric(vertical: 26),
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child: Row(
        mainAxisAlignment:
            isDesktop ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isDesktop)
            SvgPicture.asset(
              'assets/images/undraw_education_f8ru.svg',
              width: kMaxWidth * .25,
              allowDrawingOutsideViewBox: true,
            ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ข่าวรับสมัคร',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: isDesktop ? 40 : 26),
                ),
                Text(
                  'อยู่ระหว่างการพัฒนาอยู่ระหว่างการพัฒนา...',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: isDesktop ? 22 : 16),
                ),
                KTextLink(
                  text: 'ดูเพิ่มเติม',
                  textSize: 16,
                  arrowIcon: true,
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
