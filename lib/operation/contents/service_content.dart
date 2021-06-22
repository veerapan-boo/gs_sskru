import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/service_controller.dart';
import 'package:gs_sskru/models/service_model.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class ServiceContent extends GetView<ServiceController> {
  final _titleLink = TitleLinkModel().getValue;

  @override
  Widget build(BuildContext context) {
    List<List<ServiceModel>> data = [
      controller.getAcademic,
      controller.getOther,
      controller.getStaff,
    ];
    List<Widget> _listService = List.generate(
      3,
      (index) {
        return Obx(
          () => Padding(
            padding: context.isPhone
                ? EdgeInsets.symmetric(vertical: kDefaultPadding)
                : EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titleLink.data![index + 4].headTitle,
                  style: context.textTheme.headline5!.copyWith(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 8),
                for (var _elemSubTitle in data[index])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: KDialogEdit(
                      title: "ลิงค์${_elemSubTitle.text}",
                      child: KTextLink(
                        text: _elemSubTitle.text!,
                        colors: Colors.black54,
                        maxWidth: context.isTablet
                            ? kMaxWidth / 6
                            : context.width / 1.4,
                        onPressed: () {
                          k_launchURL(url: _elemSubTitle.link!);
                        },
                      ),
                      type: DialogEditType.linkOnly(
                        link: _elemSubTitle.link ?? notFound,
                        onSubmitPress: (link) {
                          controller.updateService(
                            doc: UpdateServiceTo.values[index],
                            id: _elemSubTitle.id!,
                            key: ServiceKey.link,
                            value: link,
                          );
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
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
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: kDefaultPadding) * 2.5,
            child: Divider(height: 0, color: Colors.grey[300]),
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
