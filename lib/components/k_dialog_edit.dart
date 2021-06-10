import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/controllers/firebase_auth_service_controller.dart';
import 'package:gs_sskru/operation/contents/home_content/components/form_action_link.dart';
import 'package:gs_sskru/util/constants.dart';

enum DialogEditType { forCenter, forLeft }

// ignore: must_be_immutable
class KDialogEdit extends StatefulWidget {
  KDialogEdit(
      {Key? key,
      required this.message,
      required this.link,
      required this.widget,
      this.type = DialogEditType.forLeft})
      : super(key: key);
  Widget widget;
  String message;
  String link;
  DialogEditType type;
  @override
  _KDialogEditState createState() => _KDialogEditState();
}

class _KDialogEditState extends State<KDialogEdit> {
  late TextEditingController _textController = TextEditingController();
  late TextEditingController _linkController = TextEditingController();

  bool _hovering = false;

  void _showDialog() {
    Get.defaultDialog(
      title: 'title',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: FormActionLink(
          inputWidth: context.width * .7,
          labelText: 'labelText',
          linkText: 'linkText',
          onClosePress: () {
            Get.back();
          },
          onSubmitPress: () {},
          textController: _textController,
          linkController: _linkController,
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
          if (_isAuth && widget.type == DialogEditType.forCenter)
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
