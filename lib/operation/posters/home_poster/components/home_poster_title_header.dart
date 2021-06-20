import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/home_poster_contect.dart';
import 'package:gs_sskru/util/constants.dart';

class TitleHeader extends StatefulWidget {
  const TitleHeader({
    Key? key,
  }) : super(key: key);

  @override
  _TitleHeaderState createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader> {
  @override
  Widget build(BuildContext context) {
    var textHead = context.textTheme.apply(
      bodyColor: Colors.black54,
      displayColor: Colors.black54,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            'สำนักงานบัณฑิตศึกษา',
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: context
                .responsiveValue(
                  desktop: textHead.headline2,
                  tablet: textHead.headline4,
                  mobile: textHead.headline4?.copyWith(
                    fontSize: 28,
                  ),
                )
                ?.copyWith(
                  color: Colors.black87,
                ),
          ),
        ),
        Text(
          'มหาวิทยาลัยราชภัฏศรีสะเกษ',
          style: context.textTheme.headline6!.copyWith(
            color: Colors.black54,
            fontWeight: FontWeight.w300,
          ),
        ),
        if (context.isPhone) SizedBox(height: kDefaultPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.responsiveValue(
                desktop: context.width * .5,
                tablet: context.width * .5,
                mobile: context.width - (kDefaultPadding * 2),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'เว็บไซต์หลักสำนักงานบัณฑิตศึกษา มหาวิทยาลัยราชภัฏศรีสะเกษ',
                      overflow: TextOverflow.fade,
                      style: context.textTheme.subtitle2!.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: kDefaultPadding * 1.4),
        HomePostContect()
      ],
    );
  }
}
