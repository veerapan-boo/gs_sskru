import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/models/course_model.dart';

enum CourseKeys {
  title,
  text,
  link,
}

class CourseController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<CourseModel> _liteCourses = <CourseModel>[].obs;
  RxList<CourseModel> _liteOtherCourse = <CourseModel>[].obs;

  List<CourseModel> get getListCourse => _liteCourses;
  List<CourseModel> get getListOtherCourse => _liteOtherCourse;

  @override
  void onInit() async {
    super.onInit();
    await fetchCourseData();
  }

  Future fetchCourseData() async {
    try {
      final courseQuerySnapshot =
          await FirebaseFirestore.instance.collection("course").get();

      courseQuerySnapshot.docs.forEach((element) {
        if (element.reference.id == 'courses') {
          final data = element.data();
          data.forEach((key, value) {
            _liteCourses
                .add(CourseModel.fromJson(value as Map<String, dynamic>));
          });
        }
        if (element.reference.id == 'other') {
          final data = element.data();

          data.forEach((key, value) {
            _liteOtherCourse
                .add(CourseModel.fromJson(value as Map<String, dynamic>));
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  updateOtherCourse({
    required String id,
    required CourseKeys key,
    required String value,
  }) async {
    try {
      late String keyForUpdate;
      int index = _liteOtherCourse.indexWhere((element) => element.id == id);

      switch (key) {
        case CourseKeys.title:
          keyForUpdate = "${CourseKeys.title}".split(".").last;
          _liteOtherCourse[index].title = value;
          break;
        case CourseKeys.link:
          keyForUpdate = "${CourseKeys.link}".split(".").last;
          _liteOtherCourse[index].link = value;
          break;
        case CourseKeys.text:
          keyForUpdate = "${CourseKeys.text}".split(".").last;
          _liteOtherCourse[index].text = value;
          break;
        default:
      }

      _firestore.collection("course").doc('other').set(
        {
          "$id": {"$keyForUpdate": value}
        },
        SetOptions(merge: true),
      ).whenComplete(() {
        _liteOtherCourse.refresh();
        Get.back();
        kToast(
          'อัพเดทข้อมูลสำเร็จ',
          Text('ข้อมูลกำลังอัพเดทไปยังฐานข้อมูล'),
        );
      });
    } catch (err) {
      print(err);
    }
  }
}
