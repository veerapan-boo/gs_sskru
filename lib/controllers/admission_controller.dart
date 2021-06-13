import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/models/admission/admission_detail_model.dart';
import 'package:gs_sskru/models/enroll_model.dart';

enum EnrollKeys {
  duration,
  applyLink,
}

class AddmissionController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<EnrollModel> _listEnroll = <EnrollModel>[].obs;
  Rx<String> _detail = "".obs;

  List<EnrollModel> get getListEnroll => _listEnroll;
  String get getDescription => _detail.value;

  @override
  void onInit() async {
    super.onInit();
    await fetchAdmissionData();
  }

  Future fetchAdmissionData() async {
    try {
      final admissionQuerySnapshot =
          await FirebaseFirestore.instance.collection("admission").get();

      admissionQuerySnapshot.docs.forEach((element) {
        if (element.reference.id == 'detail') {
          final _admissionDetailModel =
              AdmissionDetailModel.fromJson(element.data());
          _detail.value = _admissionDetailModel.description ?? "";
        }
        if (element.reference.id == 'enroll') {
          final data = element.data();
          data.forEach((key, value) {
            _listEnroll
                .add(EnrollModel.fromJson(value as Map<String, dynamic>));
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  updateDetail({required String value}) async {
    try {
      _firestore.collection("admission").doc('detail').set(
        {"description": value},
        SetOptions(merge: true),
      ).whenComplete(() {
        _detail.value = value;
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

  updateEnroll({
    required int type,
    required EnrollKeys key,
    required String value,
  }) async {
    try {
      late String keyForUpdate;
      int index = _listEnroll.indexWhere((element) => element.type == type);

      switch (key) {
        case EnrollKeys.applyLink:
          keyForUpdate = "${EnrollKeys.applyLink}".split(".").last;
          _listEnroll[index].applyLink = value;
          break;
        case EnrollKeys.duration:
          keyForUpdate = "${EnrollKeys.duration}".split(".").last;
          _listEnroll[index].duration = value;
          break;
        default:
      }

      _firestore.collection("admission").doc('enroll').set(
        {
          "$type": {"$keyForUpdate": value}
        },
        SetOptions(merge: true),
      ).whenComplete(() {
        _listEnroll.refresh();
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
