import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/service_controller.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class ServiceContent extends GetView<ServiceController> {
  final List<IconData> _icons = [
    Icons.calendar_today_outlined,
    Icons.rule_outlined,
    Icons.check_circle_outlined,
    Icons.menu_book_outlined,
    Icons.download_outlined,
    Icons.image_outlined
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _listService = List.generate(
      1,
      (index) {
        return Obx(
          () {
            return Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                ),
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
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: KDialogEdit(
                            direction: DirectionDialogEdit.forCenter,
                            title: "ลิงค์${controller.getOther[index].text}",
                            child: KTextLink(
                              text: controller.getOther[index].text!,
                              colors: Colors.black54,
                              maxWidth: context.isTablet
                                  ? kMaxWidth / 6
                                  : context.width / 1.4,
                              onPressed: () {
                                k_launchURL(
                                    url: controller.getOther[index].link!);
                              },
                            ),
                            type: DialogEditType.linkOnly(
                              link: controller.getOther[index].link ?? notFound,
                              onSubmitPress: (link) {
                                controller.updateService(
                                  doc: UpdateServiceTo.values[index],
                                  id: controller.getOther[index].id!,
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
                itemCount: controller.getOther.length,
              ),
            );
          },
        );
      },
    );
    Column _rowList = Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: _listService,
        ),
        SizedBox(height: kDefaultPadding * 10)
      ],
    );

    Column _colList = Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: _listService,
        ),
        SizedBox(height: kDefaultPadding * 5)
      ],
    );

    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth * .75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: kDefaultPadding) * 2.5,
          ),
          Responsive(
            mobile: _colList,
            tablet: _rowList,
            desktop: _rowList,
          )
        ],
      ),
    );
  }
}
