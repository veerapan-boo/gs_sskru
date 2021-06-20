import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class ContentAdminPoster extends StatelessWidget {
  final double subTitleFontSize = 22.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        width: kDefaultPadding * 28,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: context.responsiveValue(
            desktop: CrossAxisAlignment.start,
            tablet: CrossAxisAlignment.center,
            mobile: CrossAxisAlignment.center,
          )!,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'เข้าสู่ระบบเพื่อเข้าใช้งาน',
              style: context
                  .responsiveValue(
                    desktop: context.textTheme.headline4,
                    tablet: context.textTheme.headline4,
                    mobile: context.textTheme.headline5,
                  )!
                  .copyWith(color: Colors.black87),
            ),
            Text(
              'สำหรับเจ้าหน้าที่',
              style: context
                  .responsiveValue(
                    desktop: context.textTheme.headline6,
                    tablet: context.textTheme.headline6,
                    mobile: context.textTheme.headline6,
                  )
                  ?.copyWith(color: kPrimaryColor),
            ),
            if (!context.isPhone)
              Row(
                mainAxisAlignment: context.responsiveValue(
                  desktop: MainAxisAlignment.start,
                  tablet: MainAxisAlignment.center,
                )!,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Text(
                      'สำนักงานบัณฑิตศึกษา',
                      style: context
                          .responsiveValue(
                            desktop: context.textTheme.headline6,
                            tablet: context.textTheme.headline6,
                            mobile: context.textTheme.subtitle2,
                          )
                          ?.copyWith(color: Colors.black54),
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
                      style: context
                          .responsiveValue(
                            desktop: context.textTheme.headline6,
                            tablet: context.textTheme.headline6,
                            mobile: context.textTheme.subtitle2,
                          )
                          ?.copyWith(color: Colors.black54),
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
