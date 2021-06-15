import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/models/link_model.dart';

class NewsController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  RxList<LinkModel> _linkModel = <LinkModel>[].obs;
  RxString _educationJoinUpDescription = "".obs;

  List<LinkModel> _where({required int type}) {
    List<LinkModel> value = _linkModel;
    return value.where((element) => element.type == type).toList();
  }

  List<LinkModel> get getListAllType => _linkModel;
  List<LinkModel> get getListTypeZeroOnly => _where(type: 0);
  List<LinkModel> get getListTypeOneOnly => _where(type: 1);
  String get getEducationJoinUpDescription => _educationJoinUpDescription.value;

  set setListLinkModel(List<LinkModel> value) {
    _linkModel.value = value;
  }

  void addLinkModelToList(LinkModel value) {
    _linkModel.add(value);
  }

  void updateLinkModelInList(
      {required String id, required Map<String, dynamic> value}) {
    int index = _linkModel.indexWhere((e) => e.id == id);
    Map<String, dynamic> data = _linkModel[index].toMap();
    value.forEach((key, _value) {
      data.update(key, (_) => _value);
    });
    _linkModel[index] = LinkModel.fromMap(data);
  }

  void removeLinkModelInList({required String id}) {
    _linkModel.removeWhere((e) => e.id == id);
  }

  Future<bool> fetchNewsData() async {
    try {
      // New others
      final snapshot = await firestore.collection("news").get();

      // Description deducation join up
      final detail =
          await firestore.collection("details").doc("education_join_up").get();

      if (detail.data()!.isNotEmpty) {
        detail.data()!.forEach((key, value) {
          if (key == 'description') _educationJoinUpDescription.value = value;
        });
      }

      final listNews = snapshot.docs;
      if (listNews.isNotEmpty) {
        List<LinkModel> _listLinkModel = listNews.map((e) {
          Map<String, dynamic> data = e.data();
          return LinkModel.fromMap(data);
        }).toList();
        setListLinkModel = _listLinkModel;
      }
      return true;
    } catch (err) {
      return false;
    }
  }

  updateEducationJoinUpDescription(String value) {
    firestore.collection("details").doc("education_join_up").set(
      {"description": value},
      SetOptions(merge: true),
    ).whenComplete(() {
      _educationJoinUpDescription.value = value;
      Get.back();
      kToast(
        'อัพเดทข้อมูลสำเร็จ',
        Text('ข้อมูลกำลังอัพเดทไปยังฐานข้อมูล'),
      );
    });
  }
}
