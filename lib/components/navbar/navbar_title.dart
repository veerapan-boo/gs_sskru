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
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(image: DecorationImage(image: logo)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'สำนักงานบัณฑิตศึกษา ',
                style: context.textTheme.subtitle1,
              ),
              Text(
                'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                style: context.textTheme.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
