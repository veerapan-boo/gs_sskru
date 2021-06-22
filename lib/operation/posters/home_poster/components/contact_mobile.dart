import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class ContactMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = context.width;
    return Container(
      width: width - (kDefaultPadding * 2),
      child: LayoutBuilder(
        builder: (_, constraint) {
          double _width = (width - (kDefaultPadding * 3)) * .5;
          TextStyle textCaption = context.textTheme.caption!;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: _width,
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding * .55,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding * .55),
                      child: FaIcon(
                        FontAwesomeIcons.phone,
                        color: kPrimaryColor,
                        size: textCaption.fontSize,
                      ),
                    ),
                    Text(
                      "099-9999-999",
                      style: textCaption.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPadding),
              Container(
                width: _width,
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding * .55,
                  horizontal: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: kDefaultPadding * .55),
                      child: FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                        size: textCaption.fontSize,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Facebook Page",
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: textCaption.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
