import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:gs_sskru/controllers/about_controller.dart';
import 'package:gs_sskru/controllers/admission_controller.dart';
import 'package:gs_sskru/controllers/contact_controller.dart';
import 'package:gs_sskru/controllers/course_controller.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/controllers/service_controller.dart';

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
    Get.lazyPut<ServiceController>(
      () => ServiceController(),
    );
    Get.lazyPut<CourseController>(
      () => CourseController(),
    );
    Get.lazyPut<AboutController>(
      () => AboutController(),
    );
    Get.lazyPut<ContactController>(
      () => ContactController(),
    );
  }
}
