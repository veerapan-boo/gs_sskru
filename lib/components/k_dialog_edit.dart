import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/operation/contents/home_content/components/form_action_link.dart';
import 'package:gs_sskru/util/constants.dart';

enum DirectionDialogEdit { forCenter, forLeft }

// ignore: must_be_immutable
class KDialogEdit extends StatefulWidget {
  KDialogEdit({
    Key? key,
    required this.widget,
    required this.type,
    this.direction = DirectionDialogEdit.forLeft,
  }) : super(key: key);
  Widget widget;
  DirectionDialogEdit direction;
  DialogEditType type;

  @override
  _KDialogEditState createState() => _KDialogEditState();
}

class _KDialogEditState extends State<KDialogEdit> {
  late TextEditingController _textController;
  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    switch (widget.type.type) {
      case TypeDialogEditType.titleOnly:
        _textController = TextEditingController(text: widget.type.title);
        break;
      case TypeDialogEditType.linkOnly:
        _linkController = TextEditingController(text: widget.type.link);
        break;
      case TypeDialogEditType.all:
        _textController = TextEditingController(text: widget.type.title);
        _linkController = TextEditingController(text: widget.type.link);
        break;
      default:
    }
  }

  bool _hovering = false;

  void _showDialog() {
    Get.defaultDialog(
      title: 'title',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: FormActionLink(
          inputWidth: context.width * .7,
          type: widget.type.type == TypeDialogEditType.titleOnly
              ? FormActionLinkType.titleOnly(
                  title: widget.type.title!, textController: _textController)
              : widget.type.type == TypeDialogEditType.linkOnly
                  ? FormActionLinkType.linkOnly(
                      link: widget.type.link!, linkController: _linkController)
                  : FormActionLinkType.all(
                      title: widget.type.title!,
                      link: widget.type.link!,
                      textController: _textController,
                      linkController: _linkController,
                    ),
          onClosePress: () {
            Get.back();
          },
          onSubmitPress: () {},
          isLoading: false,
        ),
      ),
      radius: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool _isAuth =
        Get.find<FirebaseAuthServiceController>().getIsAuthenticated;
    return MouseRegion(
      onEnter: (_) => _mouseEnter(true),
      onExit: (_) => _mouseEnter(false),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isAuth && widget.direction == DirectionDialogEdit.forCenter)
            Icon(
              Icons.edit_outlined,
              color: Colors.transparent,
              size: 16,
            ),
          widget.widget,
          if (_isAuth) SizedBox(width: 4),
          InkWell(
            onTap: _showDialog,
            child: Icon(
              Icons.edit_outlined,
              color: _hovering ? Colors.black54 : Colors.transparent,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}

enum TypeDialogEditType { titleOnly, linkOnly, all }

class DialogEditType {
  DialogEditType({this.link, this.title, this.type});
  final String? link;
  final String? title;
  final TypeDialogEditType? type;

  factory DialogEditType.titleOnly({required String title}) {
    return DialogEditType(
      title: title,
      type: TypeDialogEditType.titleOnly,
    );
  }
  factory DialogEditType.linkOnly({required String link}) {
    return DialogEditType(
      link: link,
      type: TypeDialogEditType.linkOnly,
    );
  }
  factory DialogEditType.all({
    required String title,
    required String link,
  }) {
    return DialogEditType(
      title: title,
      link: link,
      type: TypeDialogEditType.all,
    );
  }
}
