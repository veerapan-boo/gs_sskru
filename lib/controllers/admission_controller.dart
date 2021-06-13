import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/models/admission/admission_detail_model.dart';
import 'package:gs_sskru/models/enroll_model.dart';

class AddmissionController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  RxList<EnrollModel> _listEnroll = <EnrollModel>[].obs;
  Rx<String> _detail = "".obs;

  List<EnrollModel> get getListEnroll => _listEnroll;

  @override
  void onInit() async {
    super.onInit();
    await fetchAdmissionData();
  }

  Future fetchAdmissionData() async {
    try {
      final admissionQuerySnapshot = await FirebaseFirestore.instance.collection("admission").get();

      admissionQuerySnapshot.docs.forEach((element) {
        if (element.reference.id == 'detail') {
          final _admissionDetailModel = AdmissionDetailModel.fromJson(element.data());
          _detail.value = _admissionDetailModel.description ?? "";
        }
        if (element.reference.id == 'enroll') {
          final data = element.data();
          data.forEach((key, value) {
            _listEnroll.add(EnrollModel.fromJson(value as Map<String, dynamic>));
          });
        }
      });
    } catch (err) {
      print(err);
    }
  }

  updateEnrollApplyLink({required int type, required String link}) async {
    _firestore.collection("admission").doc('enroll').set(
      {
        "$type": {"applyLink": link}
      },
      SetOptions(merge: true),
    ).whenComplete(() {
      print('success');
    });
  }
}
