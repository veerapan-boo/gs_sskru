import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class HomePostContect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = context.width;
    return context.responsiveValue(
      desktop: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * .75,
              horizontal: kDefaultPadding * 2,
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
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: FaIcon(
                    FontAwesomeIcons.phone,
                    color: kPrimaryColor,
                    size: context.textTheme.subtitle2!.fontSize,
                  ),
                ),
                Text(
                  "099-9999-999",
                  style: context.textTheme.subtitle1!.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * .75,
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
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                    size: context.textTheme.subtitle2!.fontSize,
                  ),
                ),
                Text(
                  "สำหนักงานบัญฑิตศึกษา",
                  style: context.textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      tablet: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * .75,
              horizontal: kDefaultPadding,
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
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: FaIcon(
                    FontAwesomeIcons.phone,
                    color: kPrimaryColor,
                    size: context.textTheme.caption!.fontSize,
                  ),
                ),
                Text(
                  "099-9999-999",
                  style: context.textTheme.caption!.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * .75,
              horizontal: kDefaultPadding * .75,
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
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                    size: context.textTheme.caption!.fontSize,
                  ),
                ),
                Text(
                  "สำหนักงานบัญฑิตศึกษา",
                  style: context.textTheme.caption!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      mobile: Container(
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
      ),
    )!;
  }
}
