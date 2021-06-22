import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/models/link_model.dart';
import 'package:gs_sskru/operation/contents/home_content/components/form_action_link.dart';
import 'package:gs_sskru/operation/contents/home_content/components/list_news.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:nanoid/nanoid.dart';

class BoxNews extends StatefulWidget {
  const BoxNews({
    Key? key,
    required this.contentWidth,
    required this.title,
    required this.data,
    required this.type,
  }) : super(key: key);

  final double contentWidth;
  final String title;
  final List<LinkModel> data;
  final int type;

  @override
  _BoxNewsState createState() => _BoxNewsState();
}

class _BoxNewsState extends State<BoxNews> {
  late TextEditingController _textController;
  late TextEditingController _linkController;
  late FirebaseFirestore _firebaseFirestore;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _linkController = TextEditingController();
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  bool _isAddNews = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _inputWidth = widget.contentWidth - (kDefaultPadding * 2);
    return Container(
      constraints: BoxConstraints(minHeight: context.isPhone ? 0 : 500),
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: kDefaultPadding * 2.5, bottom: kDefaultPadding),
            child: Text(
              widget.title,
              style: context.textTheme.headline5,
            ),
          ),
          if (_isAddNews) ...{
            FormActionLink(
              inputWidth: _inputWidth,
              type: FormActionLinkType.all(
                onSubmitPress: _addLinkToDatabase,
                title: 'ข้อความข่าว',
                link: 'ลิงค์ข้อความข่าว',
                textController: _textController,
                linkController: _linkController,
              ),
              onClosePress: () {
                setState(() {
                  _isAddNews = false;
                });
              },
              isLoading: _isLoading,
            )
          },
          if (widget.data.isEmpty) ...{
            Container(
              padding: EdgeInsets.only(bottom: kDefaultPadding),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'ยังไม่มีข้อมูล',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                  ),
                  if (!_isAddNews)
                    _onAddLink(
                      title: widget.title,
                    ),
                ],
              ),
            )
          } else ...{
            if (!_isAddNews)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _onAddLink(
                      title: widget.title,
                    ),
                  ],
                ),
              ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.data.length,
              itemBuilder: (_, index) {
                return GetBuilder<FirebaseAuthServiceController>(
                  init: FirebaseAuthServiceController(),
                  builder: (_) {
                    return ListNews(
                      key: ValueKey(index),
                      data: widget.data[index],
                      width: widget.contentWidth,
                      isAuth: _.getIsAuthenticated,
                      spaceBottom: index + 1 == widget.data.length,
                    );
                  },
                );
              },
            ),
          }
        ],
      ),
    );
  }

  _onAddLink({required String title}) {
    return GetBuilder<FirebaseAuthServiceController>(
      init: FirebaseAuthServiceController(),
      builder: (_) {
        if (_.getIsAuthenticated) {
          return KTextButton(
            onPressed: () {
              setState(() {
                _isAddNews = true;
              });
            },
            text: 'เพิ่ม$title',
            mainAxisAlignment: MainAxisAlignment.center,
            textSize: 16,
          );
        }

        return SizedBox();
      },
    );
  }

  Future<bool> _validateText() async {
    if (_textController.text.trim() != "" &&
        _linkController.text.trim() != "") {
      return true;
    }
    return false;
  }

  _addLinkToDatabase() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final bool _isValidated = await _validateText();
      if (_isValidated) {
        final String linkId = nanoid();
        final DateTime dateNow = DateTime.now();
        final int type = widget.type;
        final LinkModel _linkModel = LinkModel(
          id: linkId,
          text: _textController.text,
          link: _linkController.text,
          type: type,
          createDate: dateNow,
          photoUrl: "",
        );

        _firebaseFirestore
            .collection('news')
            .doc(linkId)
            .set(_linkModel.toMap())
            .then((value) {
          Get.find<NewsController>().addLinkModelToList(_linkModel);
          setState(() {
            _isAddNews = false;
            _isLoading = false;
            _textController.clear();
            _linkController.clear();
          });
          kToast(
            'เพิ่ม${widget.title}เรียบร้อย',
            Text('ข้อมูลกำลังอัพเดทไปยังฐานข้อมูล'),
          );
        });
      } else {
        kToast(
          'เกิดข้อผิดพลาดในการเพิ่ม${widget.title}',
          Text('กรุณาตรวจกรอกข้อมูลให้ถูกต้องและครบถ้วน'),
        );
      }
    } catch (err) {
      print(err);
      setState(() {
        _isAddNews = false;
        _isLoading = false;
      });
      kToast(
        'เกิดข้อผิดพลาดในการเพิ่ม${widget.title}',
        Text('กรุณาตรวจสอบข้อผิดพลาด'),
      );
    }
  }
}
