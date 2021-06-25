// สำนักงานบัณฑิตศึกษา มหาวิทยาลัยราชภัฏศรีสะเกษ
// 319 ถนนไทยพันทา ตำบลโพธิ์ อำเภอเมือง จังหวัดศรีสะเกษ 33000
// โทรศัพท์ 0 4561 7982 โทรสาร 0 4564 3607
// E-mail : sskru.journal@gmail.com

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class ContactContent extends StatelessWidget {
  final ImageProvider _imagePoster = AssetImage(
    'assets/images/sskru_poster1.jpg',
  );
  final double height = kDefaultPadding * 30;

  @override
  Widget build(BuildContext context) {
    Column textContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "สำนักงานบัณฑิตศึกษา มหาวิทยาลัยราชภัฏศรีสะเกษ",
          style: context.textTheme.subtitle1!.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "319 ถนนไทยพันทา ตำบลโพธิ์ อำเภอเมือง จังหวัดศรีสะเกษ 33000",
          style: context.textTheme.subtitle1!.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "โทรศัพท์ 0 4561 7982 โทรสาร 0 4564 3607",
          style: context.textTheme.subtitle1!.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "E-mail : sskru.journal@gmail.com",
          style: context.textTheme.subtitle1!.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );

    Column textContentMobile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "สำนักงานบัณฑิตศึกษา",
              style: context.textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              "มหาวิทยาลัยราชภัฏศรีสะเกษ",
              style: context.textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding * 2,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "319 ถนนไทยพันทา ตำบลโพธิ์ อำเภอเมือง จังหวัดศรีสะเกษ 33000",
              style: context.textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "โทรศัพท์ 0 4561 7982",
              style: context.textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "โทรสาร 0 4564 3607",
              style: context.textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "E-mail : sskru.journal@gmail.com",
              style: context.textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: kDefaultPadding * 20,
      ),
      child: Stack(
        children: [
          if (context.isTablet)
            Positioned(
              right: 0,
              child: Container(
                width: context.width,
                height: height,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imagePoster,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: height * .75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: context.isPhone ? height * .75 : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2,
                        vertical: kDefaultPadding,
                      ),
                      color: kPrimaryColor.withOpacity(.9),
                      child: context.isPhone ? textContentMobile : textContent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
