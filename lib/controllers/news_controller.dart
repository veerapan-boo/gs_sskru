import 'dart:convert';

import 'package:get/get.dart';
import 'package:gs_sskru/models/link_model.dart';

class NewsController extends GetxController {
  RxList<LinkModel> _linkModel = <LinkModel>[].obs;

  List<LinkModel> _where({required int type}) {
    List<LinkModel> value = _linkModel;
    return value.where((element) => element.type == type).toList();
  }

  List<LinkModel> get getListAllType => _linkModel;
  List<LinkModel> get getListTypeZeroOnly => _where(type: 0);
  List<LinkModel> get getListTypeOneOnly => _where(type: 1);

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
}
