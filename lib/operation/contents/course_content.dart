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

  final _titleAddTitle = "เพิ่มหัวข้อ";
  final _titleAddText = "เพิ่มข้อความ";
  final _titleLinkCourse = "ลิงค์เนื้อหาหลักสูตร";
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth * .75),
      margin: EdgeInsets.only(bottom: kDefaultPadding * 8),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  bool isOtherCourseTitleNotEmpty =
                      _listOtherCourse[index].title != "";
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
                              // * Title
                              if (isOtherCourseTitleNotEmpty) ...{
                                KDialogEdit(
                                  title: _listOtherCourse[index].title,
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.titleOnly(
                                      title: _listOtherCourse[index].title!,
                                      onSubmitPress: (title) {
                                        _courseController.updateCourse(
                                            id: _listOtherCourse[index].id!,
                                            key: CourseKeys.title,
                                            value: title,
                                            docWillUpdateCourse:
                                                DocWillUpdateCourse.other);
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
                                        title: _titleAddTitle,
                                        onPressShowDialogOnChild: true,
                                        direction: DirectionDialogEdit.forLeft,
                                        type: DialogEditType.titleOnly(
                                          title: "",
                                          onSubmitPress: (title) {
                                            _courseController.updateCourse(
                                              id: _listOtherCourse[index].id!,
                                              key: CourseKeys.title,
                                              value: title,
                                              docWillUpdateCourse:
                                                  DocWillUpdateCourse.other,
                                            );
                                          },
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            _titleAddTitle,
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
                              // * Text description
                              if (_listOtherCourse[index].text != "") ...{
                                KDialogEdit(
                                  title: isOtherCourseTitleNotEmpty
                                      ? "เนื้อหา${_listOtherCourse[index].title}"
                                      : notFound,
                                  maxLines: 3,
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.titleOnly(
                                      title: _listOtherCourse[index].text!,
                                      onSubmitPress: (text) {
                                        _courseController.updateCourse(
                                          id: _listOtherCourse[index].id!,
                                          key: CourseKeys.text,
                                          value: text,
                                          docWillUpdateCourse:
                                              DocWillUpdateCourse.other,
                                        );
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
                                        title: "เนื้อหา$_titleAddText",
                                        maxLines: 3,
                                        onPressShowDialogOnChild: true,
                                        direction: DirectionDialogEdit.forLeft,
                                        type: DialogEditType.titleOnly(
                                          title: "",
                                          onSubmitPress: (text) {
                                            _courseController.updateCourse(
                                              id: _listOtherCourse[index].id!,
                                              key: CourseKeys.text,
                                              value: text,
                                              docWillUpdateCourse:
                                                  DocWillUpdateCourse.other,
                                            );
                                          },
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            "เนื้อหา$_titleAddText",
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
                                  title: _titleLinkCourse,
                                  direction: DirectionDialogEdit.forLeft,
                                  type: DialogEditType.linkOnly(
                                      link: _listOtherCourse[index].link!,
                                      onSubmitPress: (link) {
                                        _courseController.updateCourse(
                                          id: _listOtherCourse[index].id!,
                                          key: CourseKeys.link,
                                          value: link,
                                          docWillUpdateCourse:
                                              DocWillUpdateCourse.other,
                                        );
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
                                        title: "เพิ่ม$_titleLinkCourse",
                                        onPressShowDialogOnChild: true,
                                        direction: DirectionDialogEdit.forLeft,
                                        type: DialogEditType.linkOnly(
                                          link: "",
                                          onSubmitPress: (link) {
                                            _courseController.updateCourse(
                                              id: _listOtherCourse[index].id!,
                                              key: CourseKeys.link,
                                              value: link,
                                              docWillUpdateCourse:
                                                  DocWillUpdateCourse.other,
                                            );
                                          },
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            "เพิ่ม$_titleLinkCourse",
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
