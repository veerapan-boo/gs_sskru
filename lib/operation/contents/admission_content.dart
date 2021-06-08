import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:get/get.dart';

class AdmissionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Column _desktop = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
          child: Text(
            'AdmissionPoster',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
          ),
        ),
        Container(
          width: context.responsiveValue(
            desktop: context.width * .5,
            tablet: context.width - (kDefaultPadding * 2),
          ),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  'มหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษมหาวิทยาลัยราชภัฏศรีสะเกษ',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: context.responsiveValue(
              desktop: _desktop,
              tablet: _desktop,
            ),
          ),
        ],
      ),
    );
  }
}
