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

class AdmissionPoster extends GetView<FirebaseAuthServiceController> {
  final _addmissionController = Get.find<AddmissionController>();

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
      child: Row(
        children: List.generate(
          2,
          (index) {
            return Expanded(
              flex: 1,
              child: Container(
                child: Obx(
                  () {
                    final enroll = _addmissionController.getListEnroll[index];
                    bool _isData = enroll.duration != null;
                    return Column(
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
                                // TODO
                              }),
                          child: _isData
                              ? Text(
                                  "หมดเขต ${KFormatDate.getDateThai(date: enroll.duration ?? notFound, time: false)}",
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
                                    //  TODO:
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
                            Obx(
                              () => controller.getIsAuthenticated
                                  ? KDialogEdit(
                                      pressShowDialogOnChild: true,
                                      direction: DirectionDialogEdit.forCenter,
                                      type: DialogEditType.all(
                                          title: "title",
                                          link: "link",
                                          onSubmitPress: (title, link) {
                                            //  TODO:
                                            // _addmissionController
                                            //     .updateEnrollApplyLink(
                                            //         type: enroll.type!, link: "link")
                                          }),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Text(
                                          'เพิ่มลิงค์สมัคร',
                                          style: context.textTheme.subtitle1!
                                              .copyWith(
                                            color: kPrimaryColor,
                                            fontSize: context
                                                .textTheme.subtitle1!.fontSize,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            )
                          }
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
