import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/util/constants.dart';

class EducationJoinUp extends StatelessWidget {
  final ImageProvider _image = AssetImage('assets/images/sskru_poster1.jpg');
  final _navBarMenuController = Get.find<NavBarMenuController>();
  final _newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: kPrimaryColor.withOpacity(.85),
      child: Center(
        child: Padding(
          padding: context.responsiveValue(
            desktop: EdgeInsets.all(kDefaultPadding * 8),
            tablet: EdgeInsets.all(kDefaultPadding * 4),
            mobile: EdgeInsets.symmetric(vertical: kDefaultPadding * 4),
          ) as EdgeInsets,
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 26),
            // padding: const EdgeInsets.symmetric(vertical: 36.0),
            child: Row(
              // mainAxisAlignment: context.isTablet
              //     ? MainAxisAlignment.spaceAround
              //     : MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // if (context.isTablet)
                //   Expanded(
                //     flex: 1,
                //     child: Container(
                //       constraints: BoxConstraints(minHeight: 500),
                //       // width: kMaxWidth * .25,
                //       // height: kMaxWidth * .25,
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: _image,
                //           fit: BoxFit.fitHeight,
                //         ),
                //       ),
                //     ),
                //   ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ข่าวรับสมัคร',
                      style: context.textTheme.headline4!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * .5),
                    Obx(
                      () {
                        String descriptionJoinUp =
                            _newsController.getEducationJoinUpDescription;
                        return KDialogEdit(
                          child: Container(
                            width: context.isPhone
                                ? context.width - kDefaultPadding * 2
                                : context.width * .6,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    descriptionJoinUp,
                                    overflow: TextOverflow.fade,
                                    style:
                                        context.textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          type: DialogEditType.titleOnly(
                            title: descriptionJoinUp,
                            onSubmitPress: (title) {
                              _newsController
                                  .updateEducationJoinUpDescription(title);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: kDefaultPadding),
                    KTextLink(
                      text: 'สมัครตอนนี้',
                      arrowIcon: true,
                      textSize: context.textTheme.headline6!.fontSize,
                      colors: Colors.white,
                      onPressed: () {
                        _navBarMenuController.setSelectedIndex(2);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
