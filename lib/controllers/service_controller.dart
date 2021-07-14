import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/models/service_model.dart';

enum ServiceKey { text, link }
enum UpdateServiceTo { academic, other, staff }

class ServiceController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<ServiceModel> _listAcademic = <ServiceModel>[].obs;
  RxList<ServiceModel> _listStaff = <ServiceModel>[].obs;
  RxList<ServiceModel> _listOther = <ServiceModel>[].obs;

  List<ServiceModel> get getAcademic => _listAcademic;
  List<ServiceModel> get getStaff => _listStaff;
  List<ServiceModel> get getOther => _listOther;

  @override
  void onInit() async {
    super.onInit();
    await fetchServiceData();
  }

  Future fetchServiceData() async {
    try {
      final serviceQuerySnapshot = await _firestore.collection("service").get();

      serviceQuerySnapshot.docs.forEach((element) {
        if (element.reference.id == 'academic') {
          final data = element.data();
          data.forEach((key, value) {
            _listAcademic
                .add(ServiceModel.fromJson(value as Map<String, dynamic>));
          });
        }
        if (element.reference.id == 'other') {
          final data = element.data();
          data.forEach((key, value) {
            _listOther
                .add(ServiceModel.fromJson(value as Map<String, dynamic>));
          });
        }
        if (element.reference.id == 'staff') {
          final data = element.data();
          data.forEach((key, value) {
            _listStaff
                .add(ServiceModel.fromJson(value as Map<String, dynamic>));
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  updateService({
    required UpdateServiceTo doc,
    required String id,
    required ServiceKey key,
    required String value,
  }) async {
    try {
      late String keyForUpdate;
      late String docForUpdate;
      int index;
      split(v) => "$v".split(".").last;
      bool _isText = key == ServiceKey.text;
      bool _isLink = key == ServiceKey.link;

      // Document for update value
      if (doc == UpdateServiceTo.academic) {
        index = _listAcademic.indexWhere((e) => e.id == id);
        docForUpdate = split("${UpdateServiceTo.academic}");
        if (_isText) _listAcademic[index].text = value;
        if (_isLink) _listAcademic[index].link = value;
      }
      if (doc == UpdateServiceTo.other) {
        index = _listOther.indexWhere((e) => e.id == id);
        docForUpdate = split("${UpdateServiceTo.other}");
        if (_isText) _listOther[index].text = value;
        if (_isLink) _listOther[index].link = value;
      }
      if (doc == UpdateServiceTo.staff) {
        index = _listStaff.indexWhere((e) => e.id == id);
        docForUpdate = split("${UpdateServiceTo.staff}");
        if (_isText) _listStaff[index].text = value;
        if (_isLink) _listStaff[index].link = value;
      }

      // Key for update on document
      if (_isText) keyForUpdate = split("${ServiceKey.text}");
      if (_isLink) keyForUpdate = split("${ServiceKey.link}");

      _firestore.collection("service").doc(docForUpdate).set(
        {
          "$id": {"$keyForUpdate": value}
        },
        SetOptions(merge: true),
      ).whenComplete(() {
        if (doc == UpdateServiceTo.academic) _listAcademic.refresh();
        if (doc == UpdateServiceTo.other) _listOther.refresh();
        if (doc == UpdateServiceTo.staff) _listStaff.refresh();
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
