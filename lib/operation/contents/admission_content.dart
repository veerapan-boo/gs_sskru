import 'package:flutter/material.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/admission/enroll_model.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:get/get.dart';

class AdmissionContent extends StatelessWidget {
  final ImageProvider _imageTwo = AssetImage('assets/images/degree_cap2.png');
  final ImageProvider _imageThree = AssetImage('assets/images/degree_cap3.png');
  final _addmissionController = Get.find<AddmissionController>();
  final _firebaseAuthServiceController =
      Get.find<FirebaseAuthServiceController>();
  @override
  Widget build(BuildContext context) {
    final title = TitleLinkModel().getValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 10),
      child: Obx(
        () {
          final enroll = _addmissionController.getListEnroll;

          var row = Row(
            children: [
              Expanded(
                flex: 1,
                child: degreeOne(enroll, title, context),
              ),
              SizedBox(
                height: 180,
                child: VerticalDivider(thickness: 1, color: Colors.grey[200]),
              ),
              Expanded(
                flex: 1,
                child: degreeTwo(enroll, title, context),
              ),
            ],
          );

          var column = Column(
            children: [
              degreeOne(enroll, title, context),
              SizedBox(
                height: 100,
                width: context.width - (kDefaultPadding * 2),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[200],
                ),
              ),
              degreeTwo(enroll, title, context)
            ],
          );
          return context.responsiveValue(
            desktop: Container(
              width: kMaxWidth,
              child: row,
            ),
            tablet: row,
            mobile: column,
          )!;
        },
      ),
    );
  }

  Column degreeTwo(
    List<EnrollModel> enroll,
    TitleLinkModel title,
    BuildContext context,
  ) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 90),
          // width: kMaxWidth * .25,
          // height: kMaxWidth * .25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageThree,
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                Colors.white24,
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        SizedBox(height: kDefaultPadding),
        Text(
          enroll[1].type != null
              ? "ระดับ${title.data![2].subTitle[enroll[1].type!].text}"
              : notFound,
          style: context
              .responsiveValue(
                desktop: context.textTheme.headline5,
                tablet: context.textTheme.headline5,
                mobile: context.textTheme.headline6,
              )
              ?.copyWith(
                color: Colors.black54,
              ),
        ),
        KDialogEdit(
          direction: DirectionDialogEdit.forCenter,
          type: DialogEditType.titleOnly(
              title: enroll[1].duration ?? notFound,
              onSubmitPress: (title) {
                _addmissionController.updateEnroll(
                    type: enroll[1].type!,
                    key: EnrollKeys.duration,
                    value: title);
              }),
          child: enroll.isNotEmpty
              ? Text(
                  "หมดเขต ${enroll[1].duration != "" ? KFormatDate.getDateThai(date: enroll[1].duration!, time: false) : notFound}",
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
        if (enroll.isNotEmpty)
          if (enroll[1].applyLink != "") ...{
            KDialogEdit(
              direction: DirectionDialogEdit.forCenter,
              type: DialogEditType.linkOnly(
                  link: enroll[1].applyLink!,
                  onSubmitPress: (link) {
                    _addmissionController.updateEnroll(
                        type: enroll[1].type!,
                        key: EnrollKeys.applyLink,
                        value: link);
                  }),
              child: KTextButton(
                onPressed: () => k_launchURL(url: enroll[1].applyLink!),
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
                            type: enroll[1].type!,
                            key: EnrollKeys.applyLink,
                            value: link);
                      },
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'เพิ่มลิงค์สมัคร',
                        style: context.textTheme.subtitle1!.copyWith(
                          color: kPrimaryColor,
                          fontSize: context.textTheme.subtitle1!.fontSize,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          }
      ],
    );
  }

  Column degreeOne(
    List<EnrollModel> enroll,
    TitleLinkModel title,
    BuildContext context,
  ) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 60),
          // width: kMaxWidth * .25,
          // height: kMaxWidth * .25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageTwo,
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                Colors.white24,
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        SizedBox(height: kDefaultPadding),
        Text(
          enroll[0].type != null
              ? "ระดับ${title.data![2].subTitle[enroll[0].type!].text}"
              : notFound,
          style: context
              .responsiveValue(
                  desktop: context.textTheme.headline5,
                  tablet: context.textTheme.headline5,
                  mobile: context.textTheme.headline6)
              ?.copyWith(
                color: Colors.black54,
              ),
        ),
        KDialogEdit(
          direction: DirectionDialogEdit.forCenter,
          type: DialogEditType.titleOnly(
              title: enroll[0].duration ?? notFound,
              onSubmitPress: (title) {
                _addmissionController.updateEnroll(
                    type: enroll[0].type!,
                    key: EnrollKeys.duration,
                    value: title);
              }),
          child: enroll.isNotEmpty
              ? Text(
                  "หมดเขต ${enroll[0].duration != "" ? KFormatDate.getDateThai(date: enroll[0].duration!, time: false) : notFound}",
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
        if (enroll.isNotEmpty)
          if (enroll[0].applyLink != "") ...{
            KDialogEdit(
              direction: DirectionDialogEdit.forCenter,
              type: DialogEditType.linkOnly(
                  link: enroll[0].applyLink!,
                  onSubmitPress: (link) {
                    _addmissionController.updateEnroll(
                        type: enroll[0].type!,
                        key: EnrollKeys.applyLink,
                        value: link);
                  }),
              child: KTextButton(
                onPressed: () => k_launchURL(url: enroll[0].applyLink!),
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
                            type: enroll[0].type!,
                            key: EnrollKeys.applyLink,
                            value: link);
                      },
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'เพิ่มลิงค์สมัคร',
                        style: context.textTheme.subtitle1!.copyWith(
                          color: kPrimaryColor,
                          fontSize: context.textTheme.subtitle1!.fontSize,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          }
      ],
    );
  }
}
