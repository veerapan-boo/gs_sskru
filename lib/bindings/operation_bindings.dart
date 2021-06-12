import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';

class OperationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarMenuController>(
      () => NavBarMenuController(),
    );
    Get.lazyPut<FirebaseAuthServiceController>(
      () => FirebaseAuthServiceController(),
    );
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
    Get.lazyPut<AddmissionController>(
      () => AddmissionController(),
    );
  }
}
