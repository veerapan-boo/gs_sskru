import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/admission_model.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class AdmissionPoster extends GetView<FirebaseAuthServiceController> {
  final AddmissionController _addmissionController =
      Get.find<AddmissionController>();
  @override
  Widget build(BuildContext context) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;

    final TitleLinkModel title = TitleLinkModel().getValue;

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
                    Enroll? enroll =
                        _addmissionController.getAdmission.enroll?[index];
                    bool _isData = enroll?.duration != null;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          enroll?.degree != null
                              ? "ระดับ${title.data![2].subTitle[enroll!.degree!].text}"
                              : "ไม่พบข้อมูล",
                          style: context.textTheme.headline4,
                        ),
                        KDialogEdit(
                          direction: DirectionDialogEdit.forCenter,
                          type: DialogEditType.titleOnly(title: '2020-02-04'),
                          child: _isData
                              ? Text(
                                  "หมดเขต ${KFormatDate.getDateThai(date: DateTime.now().toString(), time: false)}",
                                  style: context.textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                                )
                              : Text(
                                  "ไม่พบข้อมูลการเปิดรับสมัคร",
                                  style: context.textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        if (_isData)
                          if (enroll!.applyLink != "")
                            KDialogEdit(
                              direction: DirectionDialogEdit.forCenter,
                              type: DialogEditType.linkOnly(
                                  link: enroll.applyLink!),
                              child: KTextButton(
                                onPressed: () {},
                                text: 'สมัครเรียน',
                                mainAxisAlignment: MainAxisAlignment.center,
                                textSize: deadlineDateSize,
                              ),
                            )
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
