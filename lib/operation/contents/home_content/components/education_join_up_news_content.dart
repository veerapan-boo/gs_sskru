import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class EducationJoinUp extends StatelessWidget {
  final ImageProvider _image = AssetImage('assets/images/sskru_poster1.jpg');
  final _navBarMenuController = Get.find<NavBarMenuController>();
  final _newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kPrimaryColor.withOpacity(.75),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding * 4),
          child: Container(
            constraints: BoxConstraints(maxWidth: kMaxWidth),
            // margin: EdgeInsets.symmetric(vertical: 26),
            // padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Row(
              mainAxisAlignment: context.isTablet
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (context.isTablet)
                  Expanded(
                    flex: 1,
                    child: Container(
                      constraints: BoxConstraints(minHeight: 500),
                      // width: kMaxWidth * .25,
                      // height: kMaxWidth * .25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ข่าวรับสมัคร',
                                style: context.textTheme.headline4),
                            Obx(
                              () {
                                String descriptionJoinUp = _newsController
                                    .getEducationJoinUpDescription;

                                return KDialogEdit(
                                  child: Container(
                                    width: context.isTablet
                                        ? kMaxWidth * .3
                                        : context.width - kDefaultPadding * 2,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            descriptionJoinUp,
                                            style: context.textTheme.headline6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  type: DialogEditType.titleOnly(
                                      title: descriptionJoinUp,
                                      onSubmitPress: (title) {
                                        _newsController
                                            .updateEducationJoinUpDescription(
                                                title);
                                      }),
                                );
                              },
                            ),
                            SizedBox(height: 4),
                            KDialogEdit(
                              child: KTextLink(
                                text: 'ดูเพิ่มเติม',
                                arrowIcon: true,
                                onPressed: () {
                                  _navBarMenuController.setSelectedIndex(2);
                                },
                              ),
                              type: DialogEditType.linkOnly(
                                link: 'ดูเพิ่มเติม',
                                onSubmitPress: (title) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
