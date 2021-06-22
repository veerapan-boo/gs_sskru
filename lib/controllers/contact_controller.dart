import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/models/contact_model.dart';

enum ContactKeys {
  title,
  text,
  link,
}
enum DocWillUpdateContact {
  phone_number,
  socials /* เพิ่มตาม Document firestore ที่ต้องการ*/
}

class ContactController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<ContactModel> _listPhoneNumber = <ContactModel>[].obs;
  RxList<ContactModel> _listSocials = <ContactModel>[].obs;

  List<ContactModel> get getlistPhoneNumber => _listPhoneNumber;
  List<ContactModel> get getListSocials => _listSocials;

  @override
  void onInit() async {
    super.onInit();
    await fetchAboutData();
  }

  Future fetchAboutData() async {
    try {
      final contactQuerySnapshot =
          await FirebaseFirestore.instance.collection("contact").get();

      contactQuerySnapshot.docs.forEach((element) {
        if (element.reference.id ==
            "${DocWillUpdateContact.phone_number}".split('.').last) {
          final data = element.data();
          data.forEach((key, value) {
            _listPhoneNumber
                .add(ContactModel.fromJson(value as Map<String, dynamic>));
          });
        }
        if (element.reference.id ==
            "${DocWillUpdateContact.socials}".split('.').last) {
          final data = element.data();
          data.forEach((key, value) {
            _listSocials
                .add(ContactModel.fromJson(value as Map<String, dynamic>));
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  updateContact({
    required String id,
    required ContactKeys key,
    required String value,
    required DocWillUpdateContact docWillUpdateContact,
  }) async {
    try {
      // Key for update
      late String _keyForUpdate;
      // Index on list
      late int index;
      // List for update data local
      ContactModel _listlocalForUpdate;
      //  Set index from list with enum docWillUpdateContact
      switch (docWillUpdateContact) {
        case DocWillUpdateContact.phone_number:
          index = _listPhoneNumber.indexWhere((e) => e.id == id);
          _listlocalForUpdate = _listPhoneNumber[index];
          break;
        case DocWillUpdateContact.socials:
          index = _listSocials.indexWhere((e) => e.id == id);
          _listlocalForUpdate = _listSocials[index];
          break;
        /* เพิ่ม case ตาม Document firestore ที่ต้องการจัดการ*/
      }
      // Set key for update and value list contact
      switch (key) {
        case ContactKeys.title:
          _keyForUpdate = "${ContactKeys.title}".split(".").last;
          _listlocalForUpdate.title = value;
          break;
        case ContactKeys.link:
          _keyForUpdate = "${ContactKeys.link}".split(".").last;
          _listlocalForUpdate.link = value;
          break;
        case ContactKeys.text:
          _keyForUpdate = "${ContactKeys.text}".split(".").last;
          _listlocalForUpdate.text = value;
          break;
      }
      // Update firestore collection "contact"
      _firestore
          .collection("contact")
          .doc(docWillUpdateContact.toString().split(".").last)
          .set(
        {
          "$id": {"$_keyForUpdate": value}
        },
        SetOptions(merge: true),
      ).whenComplete(() {
        switch (docWillUpdateContact) {
          case DocWillUpdateContact.phone_number:
            _listPhoneNumber.refresh();
            break;
          case DocWillUpdateContact.socials:
            _listSocials.refresh();
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
