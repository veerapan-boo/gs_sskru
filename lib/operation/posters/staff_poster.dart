import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class StaffPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultPadding * 8,
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'บุคลากร',
                style: context
                    .responsiveValue(
                      desktop: context.textTheme.headline4,
                      tablet: context.textTheme.headline4,
                      mobile: context.textTheme.headline5,
                    )
                    ?.copyWith(
                      color: Colors.black87,
                    ),
              ),
              Text(
                'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                style: context.textTheme.headline6!.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
