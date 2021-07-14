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
    final List<IconData> _icons = [
      Icons.library_books_outlined,
      Icons.web_asset_rounded,
      Icons.data_usage_outlined,
      Icons.person_outline_outlined
    ];

    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth * .75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: kDefaultPadding * 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.8),
                    ),
                    itemCount: controller.getAcademic.length,
                    itemBuilder: (_, index) => Container(
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              _icons[index],
                              size: 50,
                              color: Colors.grey[500],
                            ),
                            SizedBox(height: kDefaultPadding),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: KDialogEdit(
                                direction: DirectionDialogEdit.forCenter,
                                title:
                                    "ลิงค์${controller.getAcademic[index].text}",
                                child: KTextLink(
                                  text: controller.getAcademic[index].text!,
                                  colors: Colors.black54,
                                  maxWidth: context.responsiveValue(
                                    desktop: context.width / 6.1,
                                    tablet: context.width / 5,
                                    mobile: context.width / 3,
                                  ),
                                  onPressed: () {
                                    k_launchURL(
                                        url: controller
                                            .getAcademic[index].link!);
                                  },
                                ),
                                type: DialogEditType.linkOnly(
                                  link: controller.getAcademic[index].link ??
                                      notFound,
                                  onSubmitPress: (link) {
                                    controller.updateService(
                                      doc: UpdateServiceTo.academic,
                                      id: controller.getAcademic[index].id!,
                                      key: ServiceKey.link,
                                      value: link,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: kDefaultPadding) * 5.5,
          ),
        ],
      ),
    );
  }
}
