import 'package:get/get.dart';
import 'package:gs_sskru/services/auth_service.dart';
import 'package:gs_sskru/services/news_service.dart';

Future initServices() async {
  print('starting services ...');
  await Get.putAsync(() => NewsService().init());
  await Get.putAsync(() => AuthService().init());
  print('All services started...');
}
