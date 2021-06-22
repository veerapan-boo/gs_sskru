import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/course_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/course_model.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class BoxCoursePosterDegreeTwo extends StatelessWidget {
  BoxCoursePosterDegreeTwo({
    Key? key,
    required this.data,
    required this.title,
    required this.context,
  })  : _imageTwo = AssetImage('assets/images/book2.png'),
        super(key: key);

  final List data;
  final TitleLinkModel title;
  final BuildContext context;
  final ImageProvider _imageTwo;

  final _courseController = Get.find<CourseController>();
  final _firebaseAuthServiceController =
      Get.find<FirebaseAuthServiceController>();

  final _titleAddTitleCourse = "เพิ่มหัวข้อหลักสูตร";
  final _titleAddLinkCourse = "เพิ่มลิงค์หลักสูตร";

  @override
  Widget build(BuildContext context) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _imageTwo,
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                    Colors.white24,
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(() {
          if (_courseController.getListCourse.isEmpty) {
            return Text(
              notFound,
              style: context.textTheme.headline5,
            );
          }

          CourseModel courseData = _courseController.getListCourse[1];
          return Container(
            height: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: kDefaultPadding),
                if (courseData.title != "") ...{
                  KDialogEdit(
                    title: courseData.title,
                    direction: DirectionDialogEdit.forCenter,
                    type: DialogEditType.titleOnly(
                        title: courseData.title!,
                        onSubmitPress: (title) {
                          _courseController.updateCourse(
                              id: courseData.id!,
                              key: CourseKeys.title,
                              value: title,
                              docWillUpdateCourse: DocWillUpdateCourse.courses);
                        }),
                    child: Flexible(
                      child: Text(
                        courseData.title!,
                        style: context
                            .responsiveValue(
                              desktop: context.textTheme.headline5,
                              tablet: context.textTheme.headline5,
                              mobile: context.textTheme.headline6,
                            )
                            ?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ),
                  )
                } else ...{
                  _firebaseAuthServiceController.getIsAuthenticated
                      ? KDialogEdit(
                          title: _titleAddTitleCourse,
                          onPressShowDialogOnChild: true,
                          direction: DirectionDialogEdit.forCenter,
                          type: DialogEditType.titleOnly(
                            title: "",
                            onSubmitPress: (title) {
                              _courseController.updateCourse(
                                id: courseData.id!,
                                key: CourseKeys.title,
                                value: title,
                                docWillUpdateCourse:
                                    DocWillUpdateCourse.courses,
                              );
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _titleAddTitleCourse,
                              style: context.textTheme.subtitle1!.copyWith(
                                color: kPrimaryColor,
                                fontSize: context.textTheme.subtitle1!.fontSize,
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
                },
                if (courseData.link != "") ...{
                  KDialogEdit(
                    title: courseData.title != ""
                        ? "ลิงค์${courseData.title}"
                        : notFound,
                    direction: DirectionDialogEdit.forCenter,
                    type: DialogEditType.linkOnly(
                        link: courseData.link!,
                        onSubmitPress: (link) {
                          _courseController.updateCourse(
                            id: courseData.id!,
                            key: CourseKeys.link,
                            value: link,
                            docWillUpdateCourse: DocWillUpdateCourse.courses,
                          );
                        }),
                    child: KTextButton(
                      onPressed: () => k_launchURL(url: courseData.link!),
                      text: 'ดูเพิ่มเติม',
                      mainAxisAlignment: MainAxisAlignment.center,
                      textSize: deadlineDateSize,
                    ),
                  )
                } else ...{
                  _firebaseAuthServiceController.getIsAuthenticated
                      ? KDialogEdit(
                          title: _titleAddLinkCourse,
                          onPressShowDialogOnChild: true,
                          direction: DirectionDialogEdit.forCenter,
                          type: DialogEditType.linkOnly(
                            link: "",
                            onSubmitPress: (link) {
                              _courseController.updateCourse(
                                id: courseData.id!,
                                key: CourseKeys.link,
                                value: link,
                                docWillUpdateCourse:
                                    DocWillUpdateCourse.courses,
                              );
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _titleAddLinkCourse,
                              style: context.textTheme.subtitle1!.copyWith(
                                color: kPrimaryColor,
                                fontSize: context.textTheme.subtitle1!.fontSize,
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
                }
              ],
            ),
          );
        })
      ],
    );
  }
}
