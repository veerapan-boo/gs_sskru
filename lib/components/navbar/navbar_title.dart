import 'package:flutter/material.dart';

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
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Text(
                'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
