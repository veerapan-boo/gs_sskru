import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class AdmissionPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;

    TitleLinkModel title = TitleLinkModel().getValue;

    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      constraints:
          BoxConstraints(maxWidth: kMaxWidth, minHeight: context.height * .3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "ระดับ${title.data![2].subTitle[0].text}",
                    style: context.textTheme.headline4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "หมดเขต ${KFormatDate.getDateThai(date: DateTime.now().toString(), time: false)}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: deadlineDateSize),
                    ),
                  ),
                  KTextButton(
                    onPressed: () {},
                    text: 'สมัครเรียน',
                    mainAxisAlignment: MainAxisAlignment.center,
                    textSize: deadlineDateSize,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "ระดับ${title.data![2].subTitle[1].text}",
                    style: context.textTheme.headline4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "หมดเขต ${KFormatDate.getDateThai(date: DateTime.now().toString(), time: false)}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: deadlineDateSize),
                    ),
                  ),
                  KTextButton(
                    onPressed: () {},
                    text: 'สมัครเรียน',
                    mainAxisAlignment: MainAxisAlignment.center,
                    textSize: deadlineDateSize,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
