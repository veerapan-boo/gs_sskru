import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/course_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/course_model.dart';
import 'package:gs_sskru/util/constants.dart';

class CourseContent extends StatelessWidget {
  final _courseController = Get.find<CourseController>();
  final _firebaseAuthServiceController =
      Get.find<FirebaseAuthServiceController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth * .75),
      margin: EdgeInsets.only(bottom: kDefaultPadding * 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          Obx(
            () {
              if (_courseController.getListOtherCourse.isEmpty) {
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
              List<CourseModel> _listOtherCourse =
                  _courseController.getListOtherCourse;
              return ListView.builder(
                itemCount: _listOtherCourse.length,
                shrinkWrap: true,
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
                              if (_listOtherCourse[index].title != "") ...{
                                KDialogEdit(
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.titleOnly(
                                      title: _listOtherCourse[index].title!,
                                      onSubmitPress: (title) {
                                        _courseController.updateOtherCourse(
                                            id: _listOtherCourse[index].id!,
                                            key: CourseKeys.title,
                                            value: title);
                                      }),
                                  child: Flexible(
                                    child: Text(
                                      _listOtherCourse[index].title ?? notFound,
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
                                            _courseController.updateOtherCourse(
                                                id: _listOtherCourse[index].id!,
                                                key: CourseKeys.title,
                                                value: title);
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
                              if (_listOtherCourse[index].text != "") ...{
                                KDialogEdit(
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.titleOnly(
                                      title: _listOtherCourse[index].text!,
                                      onSubmitPress: (text) {
                                        _courseController.updateOtherCourse(
                                            id: _listOtherCourse[index].id!,
                                            key: CourseKeys.text,
                                            value: text);
                                      }),
                                  child: Flexible(
                                    child: Text(
                                      _listOtherCourse[index].text!,
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
                                            _courseController.updateOtherCourse(
                                                id: _listOtherCourse[index].id!,
                                                key: CourseKeys.text,
                                                value: text);
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
                              if (_listOtherCourse[index].link != "") ...{
                                KDialogEdit(
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.linkOnly(
                                      link: _listOtherCourse[index].link!,
                                      onSubmitPress: (link) {
                                        _courseController.updateOtherCourse(
                                            id: _listOtherCourse[index].id!,
                                            key: CourseKeys.link,
                                            value: link);
                                      }),
                                  child: KTextLink(
                                    onPressed: () {
                                      k_launchURL(
                                          url: _listOtherCourse[index].link!);
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
                                            _courseController.updateOtherCourse(
                                                id: _listOtherCourse[index].id!,
                                                key: CourseKeys.link,
                                                value: link);
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
