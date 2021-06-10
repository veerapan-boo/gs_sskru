import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class AdmissionPoster extends GetView<FirebaseAuthServiceController> {
  @override
  Widget build(BuildContext context) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;

    TitleLinkModel title = TitleLinkModel().getValue;

    List<Map> _data = [
      {
        "title": title.data![2].subTitle[0].text,
        "deadlineText": "",
        "link": "",
      },
      {
        "title": title.data![2].subTitle[1].text,
        "deadlineText": "",
        "link": "",
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      constraints:
          BoxConstraints(maxWidth: kMaxWidth, minHeight: context.height * .3),
      child: Row(
        children: List.generate(
          2,
          (index) => Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ระดับ${_data[index]['title']}",
                    style: context.textTheme.headline4,
                  ),
                  !controller.getIsAuthenticated
                      ? Text(
                          "หมดเขต ${KFormatDate.getDateThai(date: DateTime.now().toString(), time: false)}",
                          style: context.textTheme.subtitle1!.copyWith(
                            color: Colors.grey,
                          ),
                        )
                      : KDialogEdit(
                          direction: DirectionDialogEdit.forCenter,
                          type: DialogEditType.linkOnly(link: 'adsads'),
                          widget: Text(
                            "หมดเขต ${KFormatDate.getDateThai(date: DateTime.now().toString(), time: false)}",
                            style: context.textTheme.subtitle1!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                  !controller.getIsAuthenticated
                      ? KTextButton(
                          onPressed: () {},
                          text: 'สมัครเรียน',
                          mainAxisAlignment: MainAxisAlignment.center,
                          textSize: deadlineDateSize,
                        )
                      : KDialogEdit(
                          direction: DirectionDialogEdit.forCenter,
                          type: DialogEditType.linkOnly(link: 'aaaa'),
                          widget: KTextButton(
                            onPressed: () {},
                            text: 'สมัครเรียน',
                            mainAxisAlignment: MainAxisAlignment.center,
                            textSize: deadlineDateSize,
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
