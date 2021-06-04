import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_button.dart';
import 'package:gs_sskru/components/buttons/k_button_outlined.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/input_text/k_input_field.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/components/toast/k_toast.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/models/link_model.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';
import 'package:nanoid/nanoid.dart';

class NewsOthersContent extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());
  final double height = kDefaultPadding * 25;
  @override
  Widget build(BuildContext context) {
    final double kSizeWidth = Responsive.kSizeWidth(context);
    final double contentWidth =
        (kSizeWidth < kMaxWidth ? kSizeWidth / 2 : kMaxWidth / 2) -
            kDefaultPadding;

    List<Widget> _listWidget = [
      // Can see the type at data_type.dart
      Obx(() => BoxNews(
            contentWidth: contentWidth,
            title: 'ข่าวนักศึกษา',
            type: 1,
            data: _newsController.getListTypeOneOnly,
          )),
      SizedBox(width: kDefaultPadding),
      Obx(
        () => BoxNews(
          contentWidth: contentWidth,
          title: 'ข่าวทุนวิจัย',
          type: 0,
          data: _newsController.getListTypeZeroOnly,
        ),
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2),
      width: kMaxWidth < kSizeWidth ? kMaxWidth : kSizeWidth,
      child: LimitedBox(
        maxHeight: height * 2,
        child: Responsive(
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _listWidget,
          ),
          mobile: Column(
            children: _listWidget,
          ),
          tablet: Column(
            children: _listWidget,
          ),
        ),
      ),
    );
  }
}

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
  final NewsController _newsController = Get.put(NewsController());
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
    final double _inputWidth = widget.contentWidth - (kDefaultPadding * 2);

    return Container(
      width: widget.contentWidth,
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 1.5),
            child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
            ),
          ),
          if (_isAddNews) ...{
            SizedBox(
              width: _inputWidth,
              child: Column(
                children: [
                  KInputField(
                    controller: _textController,
                    labelText: 'ข้อความ',
                  ),
                  KInputField(
                    controller: _linkController,
                    labelText: 'เพิ่มลิงก์',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: _inputWidth,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: KButtonOutlined(
                      text: 'ยกเลิก',
                      onPressed: () {
                        setState(() {
                          _isAddNews = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: kDefaultPadding),
                  Expanded(
                    flex: 1,
                    child: KButton(
                      text: 'บันทึก',
                      isLoading: _isLoading,
                      onPressed: _addLinkToDatabase,
                    ),
                  ),
                ],
              ),
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
              Padding(
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
                return Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      InkWell(
                        hoverColor: Colors.grey[300],
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  width: widget.contentWidth * .7,
                                  child: Text(
                                    widget.data[index].text!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                KFormatDate.getDateThai(
                                  date: '${widget.data[index].createDate}',
                                  time: false,
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index + 1 == widget.data.length) ...{
                        SizedBox(height: 30),
                      } else ...{
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: Divider(height: 0, color: Colors.grey[300]),
                        ),
                      }
                    ],
                  ),
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
          _newsController.addLinkModelToList(_linkModel);
          setState(() {
            _isAddNews = false;
            _isLoading = false;
            _textController.clear();
            _linkController.clear();
          });
          kToast(
            'เพิ่ม${widget.title}เรียบร้อย',
            'ข้อมูลกำลังอัพเดทไปยังฐานข้อมูล',
          );
        });
      } else {
        kToast(
          'เกิดข้อผิดพลาดในการเพิ่ม${widget.title}',
          'กรุณาตรวจกรอกข้อมูลให้ถูกต้องและครบถ้วน',
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
        'กรุณาตรวจสอบข้อผิดพลาด',
      );
    }
  }
}
