import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/models/ablue_model.dart';

enum AboutKeys {
  title,
  text,
  link,
}
enum DocWillUpdateAboutKeys {
  abouts, /* เพิ่มตาม Document firestore ที่ต้องการ*/
}

class AboutController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<AboutModel> _liteAbouts = <AboutModel>[].obs;

  List<AboutModel> get getListAbouts => _liteAbouts;

  @override
  void onInit() async {
    super.onInit();
    await fetchAboutData();
  }

  Future fetchAboutData() async {
    try {
      final courseQuerySnapshot =
          await FirebaseFirestore.instance.collection("about").get();

      courseQuerySnapshot.docs.forEach((element) {
        if (element.reference.id == 'abouts') {
          final data = element.data();
          data.forEach((key, value) {
            _liteAbouts.add(AboutModel.fromJson(value as Map<String, dynamic>));
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  updateAbout({
    required String id,
    required AboutKeys key,
    required String value,
    required DocWillUpdateAboutKeys docWillUpdateAboutKeys,
  }) async {
    try {
      // Key for update
      late String _keyForUpdate;
      // Index course or course other
      late int index;
      // List for update data local
      AboutModel _listlocalForUpdate;
      //  Set index from list course or course other with enum docWillUpdateCourse
      switch (docWillUpdateAboutKeys) {
        case DocWillUpdateAboutKeys.abouts:
          index = _liteAbouts.indexWhere((e) => e.id == id);
          _listlocalForUpdate = _liteAbouts[index];
          break;
        /* เพิ่ม case ตาม Document firestore ที่ต้องการจัดการ*/
      }
      // Set key for update and value list about
      switch (key) {
        case AboutKeys.title:
          _keyForUpdate = "${AboutKeys.title}".split(".").last;
          _listlocalForUpdate.title = value;
          break;
        case AboutKeys.link:
          _keyForUpdate = "${AboutKeys.link}".split(".").last;
          _listlocalForUpdate.link = value;
          break;
        case AboutKeys.text:
          _keyForUpdate = "${AboutKeys.text}".split(".").last;
          _listlocalForUpdate.text = value;
          break;
      }
      // Update firestore collection "course"
      _firestore
          .collection("about")
          .doc(docWillUpdateAboutKeys.toString().split(".").last)
          .set(
        {
          "$id": {"$_keyForUpdate": value}
        },
        SetOptions(merge: true),
      ).whenComplete(() {
        switch (docWillUpdateAboutKeys) {
          case DocWillUpdateAboutKeys.abouts:
            _liteAbouts.refresh();
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
