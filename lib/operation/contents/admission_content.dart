import 'package:flutter/material.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:get/get.dart';

class AdmissionContent extends GetView<AddmissionController> {
  @override
  Widget build(BuildContext context) {
    final Column _desktop = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding),
          child: Text(
            'เพิ่มเติม',
            style: context.textTheme.headline6!.copyWith(
              color: Colors.black87,
            ),
          ),
        ),
        Obx(
          () => Container(
            width: context.responsiveValue(
              desktop: context.width * .5,
              tablet: context.width - (kDefaultPadding * 2),
              mobile: context.width - (kDefaultPadding * 2),
            ),
            child: KDialogEdit(
              type: DialogEditType.titleOnly(
                title: controller.getDescription,
                onSubmitPress: (title) {
                  controller.updateDetail(value: title);
                },
              ),
              child: Flexible(
                child: Text(
                  controller.getDescription.isNotEmpty
                      ? controller.getDescription
                      : notFound,
                  style: context.textTheme.subtitle2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: context.responsiveValue(
                    desktop: _desktop, tablet: _desktop, mobile: _desktop),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
