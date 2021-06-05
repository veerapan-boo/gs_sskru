import 'package:flutter/material.dart';

class NavBarTitle extends StatelessWidget {
  const NavBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/sskru_logo.png',
          width: 30,
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
