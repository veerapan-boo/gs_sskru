import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/models/admission_model.dart';

class AddmissionController extends GetxController {
  Rx<AdmissionModel> _admissionModel = AdmissionModel().obs;

  AdmissionModel get getAdmission => _admissionModel.value;

  @override
  void onInit() async {
    super.onInit();
    await fetchNewsData();
  }

  set setAdmission(AdmissionModel value) {
    _admissionModel.value = value;
  }

  Future fetchNewsData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("details")
              .doc('admission')
              .get();

      Map<String, dynamic>? data = querySnapshot.data();
      if (data != null) {
        final AdmissionModel result = AdmissionModel.fromJson(data);
        _admissionModel.value = result;
      } else {
        print('ไม่พบข้อมูล');
      }
    } catch (err) {
      print(err);
    }
  }
}
