import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class AdmissionPoster extends StatelessWidget {
  final _addmissionController = Get.find<AddmissionController>();
  final _firebaseAuthServiceController =
      Get.find<FirebaseAuthServiceController>();

  @override
  Widget build(BuildContext context) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;

    final title = TitleLinkModel().getValue;

    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      constraints:
          BoxConstraints(maxWidth: kMaxWidth, minHeight: context.height * .3),
      child: Obx(
        () => Row(
          children: List.generate(
            2,
            (index) {
              final enroll = _addmissionController.getListEnroll[index];
              bool _isData = enroll.duration != null;
              return Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      enroll.type != null
                          ? "ระดับ${title.data![2].subTitle[enroll.type!].text}"
                          : notFound,
                      style: context.textTheme.headline4,
                    ),
                    KDialogEdit(
                      direction: DirectionDialogEdit.forCenter,
                      type: DialogEditType.titleOnly(
                          title: enroll.duration ?? notFound,
                          onSubmitPress: (title) {
                            _addmissionController.updateEnroll(
                                type: enroll.type!,
                                key: EnrollKeys.duration,
                                value: title);
                          }),
                      child: _isData
                          ? Text(
                              "หมดเขต ${enroll.duration != "" ? KFormatDate.getDateThai(date: enroll.duration!, time: false) : notFound}",
                              style: context.textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              "$notFoundการเปิดรับสมัคร",
                              style: context.textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    if (_isData)
                      if (enroll.applyLink != "") ...{
                        KDialogEdit(
                          direction: DirectionDialogEdit.forCenter,
                          type: DialogEditType.linkOnly(
                              link: enroll.applyLink!,
                              onSubmitPress: (link) {
                                _addmissionController.updateEnroll(
                                    type: enroll.type!,
                                    key: EnrollKeys.applyLink,
                                    value: link);
                              }),
                          child: KTextButton(
                            onPressed: () =>
                                k_launchURL(url: enroll.applyLink!),
                            text: 'สมัครเรียน',
                            mainAxisAlignment: MainAxisAlignment.center,
                            textSize: deadlineDateSize,
                          ),
                        )
                      } else ...{
                        _firebaseAuthServiceController.getIsAuthenticated
                            ? KDialogEdit(
                                pressShowDialogOnChild: true,
                                direction: DirectionDialogEdit.forCenter,
                                type: DialogEditType.linkOnly(
                                  link: "",
                                  onSubmitPress: (link) {
                                    _addmissionController.updateEnroll(
                                        type: enroll.type!,
                                        key: EnrollKeys.applyLink,
                                        value: link);
                                  },
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    'เพิ่มลิงค์สมัคร',
                                    style:
                                        context.textTheme.subtitle1!.copyWith(
                                      color: kPrimaryColor,
                                      fontSize:
                                          context.textTheme.subtitle1!.fontSize,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox()
                      }
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
