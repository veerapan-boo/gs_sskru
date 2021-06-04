import 'package:get/get.dart';
import 'package:gs_sskru/models/link_model.dart';

class StudentnNewsController extends GetxController {
  final RxList<LinkModel> _listLinkModel = <LinkModel>[].obs;

  List<LinkModel> get getListLinkModel => _listLinkModel;

  set addlistLinkModel(LinkModel value) {
    _listLinkModel.add(value);
  }
}
