import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_button.dart';
import 'package:gs_sskru/components/buttons/k_button_outlined.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/input_text/k_input_field.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/models/link_model.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';
import 'package:nanoid/nanoid.dart';

class NewsOthersContent extends StatelessWidget {
  final double height = kDefaultPadding * 25;
  @override
  Widget build(BuildContext context) {
    final double kSizeWidth = Responsive.kSizeWidth(context);
    final double contentWidth =
        (kSizeWidth < kMaxWidth ? kSizeWidth / 2 : kMaxWidth / 2) -
            kDefaultPadding;

    List<Widget> _listWidget = [
      BoxNews(
        contentWidth: contentWidth,
        title: 'ข่าวนักศึกษา',
        // Todo
        data: [],
      ),
      SizedBox(width: kDefaultPadding),
      BoxNews(
        contentWidth: contentWidth,
        title: 'ข่าวทุนวิจัย',
        // Todo
        data: [
          LinkModel(
              id: '1', createDate: '2020-5-10', text: 'test', type: 1, link: '')
        ],
      ),
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
  const BoxNews(
      {Key? key,
      required this.contentWidth,
      required this.title,
      required this.data})
      : super(key: key);

  final double contentWidth;
  final String title;
  final List<LinkModel> data;

  @override
  _BoxNewsState createState() => _BoxNewsState();
}

class _BoxNewsState extends State<BoxNews> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final FirebaseFirestore _fbfs = FirebaseFirestore.instance;
  bool _isAddNews = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.clear();
    _linkController.clear();
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.data.length,
              itemBuilder: (_, index) {
                return Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
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
                                widget.data[index].createDate!,
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

  _addLinkToDatabase() async {
    try {
      String linkId = nanoid();
      _fbfs
          .collection('news')
          .doc(linkId)
          .set(LinkModel(
                  id: linkId,
                  text: _textController.text,
                  link: _linkController.text,
                  type: 0)
              .toMap())
          .then((value) {
        setState(() {
          _isAddNews = false;
        });
      });
    } catch (err) {
      print(err);
    }
  }
}
