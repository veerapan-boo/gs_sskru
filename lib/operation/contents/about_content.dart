import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/about_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/ablue_model.dart';
import 'package:gs_sskru/util/constants.dart';

class AboutContent extends StatelessWidget {
  final _aboutController = Get.find<AboutController>();
  final _firebaseAuthServiceController =
      Get.find<FirebaseAuthServiceController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth * .75),
      margin: EdgeInsets.only(bottom: kDefaultPadding * 8),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          Obx(
            () {
              if (_aboutController.getListAbouts.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding * 2),
                      child: Text(
                        notFound,
                        style: context.textTheme.headline5,
                      ),
                    ),
                  ],
                );
              }
              List<AboutModel> _listAbouts = _aboutController.getListAbouts;
              return ListView.builder(
                itemCount: _listAbouts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding * 2),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_listAbouts[index].title != "") ...{
                                KDialogEdit(
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.titleOnly(
                                      title: _listAbouts[index].title!,
                                      onSubmitPress: (title) {
                                        _aboutController.updateAbout(
                                            id: _listAbouts[index].id!,
                                            key: AboutKeys.title,
                                            value: title,
                                            docWillUpdateAboutKeys:
                                                DocWillUpdateAboutKeys.abouts);
                                      }),
                                  child: Flexible(
                                    child: Text(
                                      _listAbouts[index].title ?? notFound,
                                      style: context.textTheme.headline5,
                                    ),
                                  ),
                                )
                              } else ...{
                                _firebaseAuthServiceController
                                        .getIsAuthenticated
                                    ? KDialogEdit(
                                        onPressShowDialogOnChild: true,
                                        direction: DirectionDialogEdit.forLeft,
                                        type: DialogEditType.titleOnly(
                                          title: "",
                                          onSubmitPress: (title) {
                                            _aboutController.updateAbout(
                                                id: _listAbouts[index].id!,
                                                key: AboutKeys.title,
                                                value: title,
                                                docWillUpdateAboutKeys:
                                                    DocWillUpdateAboutKeys
                                                        .abouts);
                                          },
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            'เพิ่มหัวข้อ',
                                            style: context.textTheme.subtitle1!
                                                .copyWith(
                                              color: kPrimaryColor,
                                              fontSize: context.textTheme
                                                  .subtitle1!.fontSize,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              },
                              SizedBox(height: 8),
                              if (_listAbouts[index].text != "") ...{
                                KDialogEdit(
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.titleOnly(
                                      title: _listAbouts[index].text!,
                                      onSubmitPress: (text) {
                                        _aboutController.updateAbout(
                                          id: _listAbouts[index].id!,
                                          key: AboutKeys.text,
                                          value: text,
                                          docWillUpdateAboutKeys:
                                              DocWillUpdateAboutKeys.abouts,
                                        );
                                      }),
                                  child: Flexible(
                                    child: Text(
                                      _listAbouts[index].text!,
                                      overflow: TextOverflow.fade,
                                      style: context.textTheme.subtitle1
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                  ),
                                )
                              } else ...{
                                _firebaseAuthServiceController
                                        .getIsAuthenticated
                                    ? KDialogEdit(
                                        onPressShowDialogOnChild: true,
                                        direction: DirectionDialogEdit.forLeft,
                                        type: DialogEditType.titleOnly(
                                          title: "",
                                          onSubmitPress: (text) {
                                            _aboutController.updateAbout(
                                              id: _listAbouts[index].id!,
                                              key: AboutKeys.text,
                                              value: text,
                                              docWillUpdateAboutKeys:
                                                  DocWillUpdateAboutKeys.abouts,
                                            );
                                          },
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            'เพิ่มข้อความ',
                                            style: context.textTheme.subtitle1!
                                                .copyWith(
                                              color: kPrimaryColor,
                                              fontSize: context.textTheme
                                                  .subtitle1!.fontSize,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              },
                              SizedBox(height: 8),
                              if (_listAbouts[index].link != "") ...{
                                KDialogEdit(
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.linkOnly(
                                      link: _listAbouts[index].link!,
                                      onSubmitPress: (link) {
                                        _aboutController.updateAbout(
                                          id: _listAbouts[index].id!,
                                          key: AboutKeys.link,
                                          value: link,
                                          docWillUpdateAboutKeys:
                                              DocWillUpdateAboutKeys.abouts,
                                        );
                                      }),
                                  child: KTextLink(
                                    onPressed: () {
                                      k_launchURL(
                                          url: _listAbouts[index].link!);
                                    },
                                    text: "ดูเพิ่มเติม",
                                    arrowIcon: true,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              } else ...{
                                _firebaseAuthServiceController
                                        .getIsAuthenticated
                                    ? KDialogEdit(
                                        onPressShowDialogOnChild: true,
                                        direction: DirectionDialogEdit.forLeft,
                                        type: DialogEditType.linkOnly(
                                          link: "",
                                          onSubmitPress: (link) {
                                            _aboutController.updateAbout(
                                              id: _listAbouts[index].id!,
                                              key: AboutKeys.link,
                                              value: link,
                                              docWillUpdateAboutKeys:
                                                  DocWillUpdateAboutKeys.abouts,
                                            );
                                          },
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            'เพิ่มลิงค์',
                                            style: context.textTheme.subtitle1!
                                                .copyWith(
                                              color: kPrimaryColor,
                                              fontSize: context.textTheme
                                                  .subtitle1!.fontSize,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              }
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
