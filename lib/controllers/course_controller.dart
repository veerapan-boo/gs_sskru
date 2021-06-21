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
enum DocWillUpdateCourse { courses, other }

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

  updateCourse({
    required String id,
    required CourseKeys key,
    required String value,
    required DocWillUpdateCourse docWillUpdateCourse,
  }) async {
    try {
      // Key for update
      late String _keyForUpdate;
      // Index course or course other
      late int index;
      // List for update data local
      CourseModel _listlocalForUpdate;
      //  Set index from list course or course other with enum docWillUpdateCourse
      switch (docWillUpdateCourse) {
        case DocWillUpdateCourse.courses:
          index = _liteCourses.indexWhere((e) => e.id == id);
          _listlocalForUpdate = _liteCourses[index];
          break;
        case DocWillUpdateCourse.other:
          index = _liteOtherCourse.indexWhere((e) => e.id == id);
          _listlocalForUpdate = _liteOtherCourse[index];
          break;
      }
      // Set key for update and value list course or course other
      switch (key) {
        case CourseKeys.title:
          _keyForUpdate = "${CourseKeys.title}".split(".").last;
          _listlocalForUpdate.title = value;
          break;
        case CourseKeys.link:
          _keyForUpdate = "${CourseKeys.link}".split(".").last;
          _listlocalForUpdate.link = value;
          break;
        case CourseKeys.text:
          _keyForUpdate = "${CourseKeys.text}".split(".").last;
          _listlocalForUpdate.text = value;
          break;
      }
      // Update firestore collection "course"
      _firestore
          .collection("course")
          .doc(docWillUpdateCourse.toString().split(".").last)
          .set(
        {
          "$id": {"$_keyForUpdate": value}
        },
        SetOptions(merge: true),
      ).whenComplete(() {
        switch (docWillUpdateCourse) {
          case DocWillUpdateCourse.courses:
            _liteCourses.refresh();
            break;
          case DocWillUpdateCourse.other:
            _liteOtherCourse.refresh();
            break;
        }
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
