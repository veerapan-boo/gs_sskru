import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
import 'package:gs_sskru/models/title_link/title_link.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';
import 'package:nanoid/nanoid.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsOthersContent extends StatelessWidget {
  final NewsController _newsController = Get.put(NewsController());
  final double height = kDefaultPadding * 25;
  @override
  Widget build(BuildContext context) {
    final double kSizeWidth = Responsive.kSizeWidth(context);
    final double contentWidth =
        (kSizeWidth < kMaxWidth ? kSizeWidth / 2 : kMaxWidth / 2) -
            kDefaultPadding;

    List<Widget> _listWidgetDesktop = [
      // Can see the type at data_type.dart
      Obx(
        () => BoxNews(
          contentWidth: contentWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[1].text,
          type: 1,
          data: _newsController.getListTypeOneOnly,
        ),
      ),
      SizedBox(width: kDefaultPadding),
      Obx(
        () => BoxNews(
          contentWidth: contentWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[0].text,
          type: 0,
          data: _newsController.getListTypeZeroOnly,
        ),
      )
    ];

    List<Widget> _listWidgetTablet = [
      // Can see the type at data_type.dart
      Obx(
        () => BoxNews(
          contentWidth: kSizeWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[1].text,
          type: 1,
          data: _newsController.getListTypeOneOnly,
        ),
      ),
      SizedBox(height: kDefaultPadding),
      Obx(
        () => BoxNews(
          contentWidth: kSizeWidth,
          title: TitleLinkModel().getValue.data![0].subTitle[0].text,
          type: 0,
          data: _newsController.getListTypeZeroOnly,
        ),
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2),
      width: kMaxWidth < kSizeWidth ? kMaxWidth : kSizeWidth,
      child: Responsive(
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _listWidgetDesktop,
        ),
        tablet: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: _listWidgetTablet,
          ),
        ),
        mobile: Column(
          children: _listWidgetTablet,
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
          _newsController.addLinkModelToList(_linkModel);
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

class ListNews extends StatefulWidget {
  ListNews({
    required Key key,
    required this.data,
    required this.width,
    required this.isAuth,
    required this.spaceBottom,
  }) : super(key: key);

  final LinkModel data;
  final double width;
  final bool isAuth;
  final bool spaceBottom;

  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  late LinkModel data;
  late double width;
  late bool isAuth;
  late bool spaceBottom;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    width = widget.width;
    isAuth = widget.isAuth;
    spaceBottom = widget.spaceBottom;
  }

  bool _isSlideAnimationChanged = false;
  bool _isHover = false;

  late SlidableController slidableController = SlidableController(
      onSlideIsOpenChanged: onSlideIsOpenChanged,
      onSlideAnimationChanged: (Animation<double>? value) => null);

  void onSlideIsOpenChanged(bool? isOpen) {
    if (isOpen!) {
      setState(() {
        _isSlideAnimationChanged = true;
      });
    } else {
      setState(() {
        _isSlideAnimationChanged = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.grey[50]),
        highlightColor: Colors.grey[50],
        onHover: (value) {
          setState(() {
            _isHover = value;
          });
        },
        onTap: () => _launchURL(data.link!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.width,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Slidable(
                    controller: slidableController,
                    actionPane: SlidableBehindActionPane(),
                    movementDuration: Duration(milliseconds: 600),
                    actionExtentRatio: 0.15,
                    enabled: widget.isAuth,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'ลบ',
                        color: Colors.grey[50],
                        iconWidget: Icon(
                          Icons.close,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        foregroundColor: Colors.grey[600],
                        onTap: () {},
                      ),
                      IconSlideAction(
                        caption: 'แก้ไข',
                        color: Colors.grey[50],
                        iconWidget: Icon(
                          Icons.edit_outlined,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        foregroundColor: Colors.grey[600],
                        onTap: () {},
                      ),
                    ],
                    child: Container(
                      width: widget.width * .7,
                      color: Colors.grey[50],
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
                                width: widget.width * .7,
                                child: Text(
                                  widget.data.text!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: _isHover
                                        ? Colors.black87
                                        : Colors.black87.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: kDefaultPadding,
                    child: AnimatedOpacity(
                      opacity: !_isSlideAnimationChanged ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        child: Text(
                          KFormatDate.getDateThai(
                            date: '${widget.data.createDate}',
                            time: false,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // if (widget.index + 1 == widget.data.length) ...{
            if (spaceBottom) ...{
              SizedBox(height: 30),
            } else ...{
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Divider(height: 0, color: Colors.grey[300]),
              ),
            }
          ],
        ),
      ),
    );
  }

  void _launchURL(String _url) async {
    await canLaunch(_url)
        ? await launch(_url)
        : kToast(
            'ไม่สามารถเข้าลิงค์นี้ได้',
            // TODO:
            Row(
              children: [
                Text('กรุณาแจ้งไปยังผู้ดูแลระบบ'),
                SizedBox(
                  width: 8,
                ),
                Text('Facebook โดยกดที่การแจ้งเตือนนี้'),
              ],
            ), onTap: (_) {
            _launchURL('https://pub.dev/packages/url_launcher');
          });
  }
}
