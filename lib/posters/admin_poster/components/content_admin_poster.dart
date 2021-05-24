import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class ContentAdminPoster extends StatelessWidget {
  const ContentAdminPoster({
    Key? key,
  }) : super(key: key);

  final double subTitleFontSize = 22.0;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        height: kDefaultPadding * (isDesktop ? 20 : 11.5),
        width: kDefaultPadding * 24,
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'เข้าสู่ระบบเพื่อเข้าใช้งาน',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
            ),
            Text(
              'สำนักงานบัณฑิตศึกษา',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
            ),
            Row(
              mainAxisAlignment: isDesktop
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    'สำหรับเจ้าหน้าที่',
                    style: TextStyle(
                        color: kBodyTextColor,
                        fontWeight: FontWeight.w300,
                        fontSize: (isDesktop
                            ? subTitleFontSize
                            : subTitleFontSize - 2.0)),
                  ),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.grey,
                  ),
                  width: 32,
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                    style: TextStyle(
                        color: kBodyTextColor,
                        fontWeight: FontWeight.w300,
                        fontSize: (isDesktop
                            ? subTitleFontSize
                            : subTitleFontSize - 2.0)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
