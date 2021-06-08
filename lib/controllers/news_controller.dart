import 'package:cloud_firestore/cloud_firestore.dart';
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

  void removeLinkModelInList({required String id}) {
    _linkModel.removeWhere((e) => e.id == id);
  }

  Future<bool> fetchNewsData() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("news").get();
      final List<QueryDocumentSnapshot<Object?>> listNews = querySnapshot.docs;
      if (listNews.isNotEmpty) {
        List<LinkModel> _listLinkModel = listNews.map((e) {
          Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          return LinkModel.fromMap(data);
        }).toList();
        setListLinkModel = _listLinkModel;
      }
      return true;
    } catch (err) {
      return false;
    }
  }
}
