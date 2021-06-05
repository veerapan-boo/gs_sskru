import 'package:get/get.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';

class AuthService extends GetxService {
  FirebaseAuthServiceController _firebaseAuthServiceController =
      Get.put(FirebaseAuthServiceController());

  Future<AuthService> init() async {
    await _firebaseAuthServiceController.checkCurrentUser();
    return this;
  }
}
