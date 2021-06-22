import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/util/constants.dart';

class EducationJoinUp extends StatelessWidget {
  final _navBarMenuController = Get.find<NavBarMenuController>();
  final _newsController = Get.find<NewsController>();
  final title = "ข่าวรับสมัคร";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: kPrimaryColor.withOpacity(.85),
      child: Center(
        child: Padding(
          padding: context.responsiveValue(
            desktop: EdgeInsets.all(kDefaultPadding * 6),
            tablet: EdgeInsets.all(kDefaultPadding * 4),
            mobile: EdgeInsets.symmetric(vertical: kDefaultPadding * 4),
          ) as EdgeInsets,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.headline4!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    SvgPicture.asset(
                      'assets/images/undraw_Done_checking.svg',
                      width: 180,
                    ),
                    SizedBox(height: kDefaultPadding * 2),
                    // * Text description
                    Obx(
                      () {
                        String descriptionJoinUp =
                            _newsController.getEducationJoinUpDescription;
                        return KDialogEdit(
                          title: title,
                          maxLines: 4,
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
                                    style: context.responsiveValue(
                                      desktop:
                                          context.textTheme.headline6!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      tablet:
                                          context.textTheme.headline6!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      mobile:
                                          context.textTheme.subtitle1!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
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
                    // * Button enroll
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
