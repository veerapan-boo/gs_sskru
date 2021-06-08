import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class AdmissionPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      title.data![2].subTitle[0].text,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
                    ),
                    KTextButton(
                      onPressed: () {},
                      text: 'สมัคร',
                      mainAxisAlignment: MainAxisAlignment.center,
                      textSize: 16,
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Text(
                      title.data![2].subTitle[1].text,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
                    ),
                    KTextButton(
                      onPressed: () {},
                      text: 'สมัคร',
                      mainAxisAlignment: MainAxisAlignment.center,
                      textSize: 16,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
