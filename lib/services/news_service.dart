import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/models/link_model.dart';

class NewsService extends GetxService {
  NewsController _newsController = Get.put(NewsController());
  Future<NewsService> init() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("news").get();
    final List<QueryDocumentSnapshot<Object?>> listNews = querySnapshot.docs;
    if (listNews.isNotEmpty) {
      List<LinkModel> _listLinkModel = listNews.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return LinkModel.fromMap(data);
      }).toList();
      _newsController.setListLinkModel = _listLinkModel;
      return this;
    }
    return this;
  }
}
