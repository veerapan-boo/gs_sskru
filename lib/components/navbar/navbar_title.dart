import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarTitle extends StatelessWidget {
  final ImageProvider logo = AssetImage(
    'assets/images/sskru_logo.png',
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        context.responsiveValue(
          desktop: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(image: DecorationImage(image: logo)),
          ),
          tablet: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(image: DecorationImage(image: logo)),
          ),
          mobile: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(image: DecorationImage(image: logo)),
          ),
        )!,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'สำนักงานบัณฑิตศึกษา ',
                style: context.textTheme.headline6,
              ),
              Text(
                'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                style: context.textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
