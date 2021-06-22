import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/util/constants.dart';

class AdmissionPoster extends StatelessWidget {
  final _addmissionController = Get.find<AddmissionController>();

  final _initTitle = "การรับสมัครนักศึกษา";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _initTitle,
                        style: context
                            .responsiveValue(
                                desktop: context.textTheme.headline4,
                                tablet: context.textTheme.headline4,
                                mobile: context.textTheme.headline5)
                            ?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Container(
                            width: context.responsiveValue(
                              desktop: context.width * .5,
                              tablet: context.width * .7,
                              mobile: context.width - (kDefaultPadding * 2),
                            ),
                            child: KDialogEdit(
                              title: _initTitle,
                              maxLines: 8,
                              direction: DirectionDialogEdit.forCenter,
                              type: DialogEditType.titleOnly(
                                title: _addmissionController.getDescription,
                                onSubmitPress: (title) {
                                  _addmissionController.updateDetail(
                                    value: title,
                                  );
                                },
                              ),
                              child: Flexible(
                                child: Text(
                                  _addmissionController
                                          .getDescription.isNotEmpty
                                      ? _addmissionController.getDescription
                                      : notFound,
                                  style: context.textTheme.subtitle2!.copyWith(
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
