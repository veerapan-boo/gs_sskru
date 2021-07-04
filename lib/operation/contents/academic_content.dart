import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/service_controller.dart';
import 'package:gs_sskru/util/constants.dart';

class AcademicContent extends GetView<ServiceController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: kDefaultPadding * 2),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.getAcademic.length,
            itemBuilder: (_, index) {
              return Column(
                crossAxisAlignment: context.isPhone
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: kMaxWidth),
                    child: KDialogEdit(
                      direction: DirectionDialogEdit.forCenter,
                      title: "ลิงค์${controller.getAcademic[index].text}",
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: KTextLink(
                          text: controller.getAcademic[index].text!,
                          colors: Colors.black54,
                          maxWidth: context.width - (kDefaultPadding * 4),
                          fontSize: context.textTheme.headline6!.fontSize,
                          onPressed: () {
                            k_launchURL(
                                url: controller.getAcademic[index].link!);
                          },
                        ),
                      ),
                      type: DialogEditType.linkOnly(
                        link: controller.getAcademic[index].link ?? notFound,
                        onSubmitPress: (link) {
                          controller.updateService(
                            doc: UpdateServiceTo.staff,
                            id: controller.getAcademic[index].id!,
                            key: ServiceKey.link,
                            value: link,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding) * 5.5,
        ),
      ],
    );
  }
}
