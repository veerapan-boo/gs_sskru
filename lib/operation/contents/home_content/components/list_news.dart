import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_dialog.dart';
import 'package:gs_sskru/components/k_format_date.dart';
import 'package:gs_sskru/components/toast/k_toast.dart';
import 'package:gs_sskru/controllers/news_controller.dart';
import 'package:gs_sskru/data/link_others.dart';
import 'package:gs_sskru/models/link_model.dart';
import 'package:gs_sskru/operation/contents/home_content/components/form_action_link.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late double _inputWidth;
  late bool isAuth;
  late bool spaceBottom;
  late TextEditingController _textController = TextEditingController();
  late TextEditingController _linkController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final NewsController _newsController = Get.put(NewsController());
  @override
  void initState() {
    super.initState();
    data = widget.data;
    width = widget.width;
    _inputWidth = width - (kDefaultPadding * 2);
    isAuth = widget.isAuth;
    spaceBottom = widget.spaceBottom;
    _textController = TextEditingController(text: data.text);
    _linkController = TextEditingController(text: data.link);
  }

  bool _isSlideAnimationChanged = false;
  bool _isHover = false;
  bool _isEdit = false;
  bool _isLoading = false;

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
                        onTap: () {
                          kDialog(
                            title: 'ยืนยันการลบ',
                            content: Text(
                              'คุณต้องการลบลิงค์ข่าวนี้หรือไม่ ?',
                            ),
                            onConfirm: _removeLinkOnDatabase,
                          );
                        },
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
                        onTap: () {
                          setState(() {
                            _isEdit = true;
                          });
                        },
                      ),
                    ],
                    child: Container(
                      width: widget.width * .7,
                      color: Colors.grey[50],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding,
                        ),
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
            if (_isEdit)
              Center(
                child: FormActionLink(
                  inputWidth: _inputWidth,
                  labelText: 'ข้อความข่าว',
                  linkText: 'ลิงค์ข้อความข่าว',
                  textController: _textController,
                  linkController: _linkController,
                  onClosePress: () {
                    setState(() {
                      _isEdit = false;
                    });
                  },
                  onSubmitPress: _editLinkToDatabase,
                  isLoading: _isLoading,
                ),
              ),
            if (widget.spaceBottom) ...{
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

  Future<bool> _validateText() async {
    if (_textController.text.trim() != "" &&
        _linkController.text.trim() != "") {
      return true;
    }
    return false;
  }

  _editLinkToDatabase() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final bool _isValidated = await _validateText();
      if (_isValidated) {
        final Map<String, dynamic> _linkModel = {
          "text": _textController.text,
          "link": _linkController.text,
        };

        _firebaseFirestore
            .collection('news')
            .doc(data.id)
            .update(_linkModel)
            .then((value) {
          _newsController.updateLinkModelInList(
              id: data.id!, value: _linkModel);
          setState(() {
            _isEdit = false;
            _isLoading = false;
          });

          kToast(
            'แก้ไขสำเร็จ !',
            Text('ข้อมูลกำลังอัพเดทไปยังฐานข้อมูล'),
          );
        });
      } else {
        kToast(
          'เกิดข้อผิดพลาดในการแก้ไข',
          Text('กรุณาตรวจกรอกข้อมูลให้ถูกต้องและครบถ้วน'),
        );
      }
    } catch (err) {
      print(err);
      setState(() {
        _isEdit = false;
        _isLoading = false;
      });
      kToast(
        'เกิดข้อผิดพลาดในการแก้ไข',
        Text('กรุณาตรวจสอบข้อผิดพลาด'),
      );
    }
  }

  _removeLinkOnDatabase() async {
    try {
      setState(() {});
      _firebaseFirestore.collection('news').doc(data.id).delete().then((value) {
        Get.back();
        _newsController.removeLinkModelInList(id: data.id!);
        setState(() {
          _isEdit = false;
        });
        kToast(
          'ลบลิงค์สำเร็จ !',
          Text('ข้อมูลกำลังอัพเดทไปยังฐานข้อมูล'),
        );
      });
    } catch (err) {
      Get.back();
      setState(() {
        _isEdit = false;
      });
      kToast(
        'เกิดข้อผิดพลาดในการลบ',
        Text('กรุณาตรวจสอบข้อผิดพลาด'),
      );
    }
  }

  void _launchURL(String _url) async {
    await canLaunch(_url)
        ? await launch(_url)
        : kToast(
            'ไม่สามารถเข้าลิงค์นี้ได้',
            Row(
              children: [
                Text('กรุณาแจ้งไปยังผู้ดูแลระบบ'),
                SizedBox(
                  width: 8,
                ),
                Text('Facebook โดยกดที่การแจ้งเตือนนี้'),
              ],
            ),
            onTap: (_) {
              _launchURL(link_others['facebook']);
            },
          );
  }
}
