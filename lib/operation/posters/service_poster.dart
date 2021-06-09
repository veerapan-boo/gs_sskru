import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class ServicePoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultPadding * 8,
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'บริการและช่วยเหลือ',
                    style: context.textTheme.headline4,
                  ),
                  Text(
                    'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                    style: context.textTheme.headline6,
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
