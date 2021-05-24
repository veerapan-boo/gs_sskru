import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class HomePoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultPadding * 20,
      constraints: BoxConstraints(maxWidth: kMaxWidth),
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
                    'สำนักงานบัณฑิตศึกษา',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
                  ),
                  Text(
                    'มหาวิทยาลัยราชภัฏศรีสะเกษ',
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
