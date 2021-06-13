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
    required this.child,
    required this.type,
    this.direction = DirectionDialogEdit.forLeft,
    this.title,
    this.pressShowDialogOnChild = false,
    this.onSubmitPress,
  }) : super(key: key);
  Widget child;
  DirectionDialogEdit direction;
  DialogEditType type;
  String? title;
  bool pressShowDialogOnChild = false;
  var onSubmitPress;

  @override
  _KDialogEditState createState() => _KDialogEditState();
}

class _KDialogEditState extends State<KDialogEdit> {
  late TextEditingController _textController;
  late TextEditingController _linkController;
  late bool _isAuth;

  bool _hovering = false;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isAuth = Get.find<FirebaseAuthServiceController>().getIsAuthenticated;
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

  void _showDialog() {
    Get.defaultDialog(
      title: widget.title ?? 'title',
      titleStyle: TextStyle(height: 3),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: StatefulBuilder(
          builder: (_, setStateOnDialog) {
            return FormActionLink(
              inputWidth: context.width * .7,
              type: widget.type.type == TypeDialogEditType.titleOnly
                  ? FormActionLinkType.titleOnly(
                      title: widget.type.title!,
                      textController: _textController,
                      onSubmitPress: () {
                        setStateOnDialog(() {
                          _isLoading = true;
                        });
                        widget.type.onSubmitPress(_textController.text);
                      },
                    )
                  : widget.type.type == TypeDialogEditType.linkOnly
                      ? FormActionLinkType.linkOnly(
                          link: widget.type.link!,
                          linkController: _linkController,
                          onSubmitPress: () {
                            setStateOnDialog(() {
                              _isLoading = true;
                            });
                            widget.type.onSubmitPress(_linkController.text);
                          },
                        )
                      : FormActionLinkType.all(
                          title: widget.type.title!,
                          link: widget.type.link!,
                          textController: _textController,
                          linkController: _linkController,
                          onSubmitPress: () {
                            setStateOnDialog(() {
                              _isLoading = true;
                            });
                            widget.type.onSubmitPress(
                                _textController.text, _linkController.text);
                          },
                        ),
              onClosePress: () {
                Get.back();
              },
              isLoading: _isLoading,
            );
          },
        ),
      ),
      radius: 0,
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _mouseEnter(true),
      onExit: (_) => _mouseEnter(false),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isAuth &&
              widget.direction == DirectionDialogEdit.forCenter &&
              !widget.pressShowDialogOnChild)
            Icon(
              Icons.edit_outlined,
              color: Colors.transparent,
              size: 16,
            ),
          if (widget.pressShowDialogOnChild) ...{
            InkWell(
              onTap: _showDialog,
              child: widget.child,
            )
          } else ...{
            widget.child
          },
          if (_isAuth && !widget.pressShowDialogOnChild) ...{
            SizedBox(width: 4),
            InkWell(
              onTap: _showDialog,
              child: Icon(
                Icons.edit_outlined,
                color: _hovering ? Colors.black54 : Colors.transparent,
                size: 16,
              ),
            ),
          }
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
  DialogEditType({this.link, this.title, this.type, this.onSubmitPress});
  final String? link;
  final String? title;
  final TypeDialogEditType? type;
  var onSubmitPress;
  late Function(String title) pressOnTypeTitle;
  late Function(String link) pressOnTypeLink;
  late Function(String title, String link) pressOnTypeAll;

  factory DialogEditType.titleOnly({
    required String title,
    required Function(String title) onSubmitPress,
  }) {
    return DialogEditType(
      title: title,
      type: TypeDialogEditType.titleOnly,
      onSubmitPress: onSubmitPress,
    );
  }
  factory DialogEditType.linkOnly({
    required String link,
    required Function(String link) onSubmitPress,
  }) {
    return DialogEditType(
      link: link,
      type: TypeDialogEditType.linkOnly,
      onSubmitPress: onSubmitPress,
    );
  }

  factory DialogEditType.all({
    required String title,
    required String link,
    required Function(String title, String link) onSubmitPress,
  }) {
    return DialogEditType(
      title: title,
      link: link,
      type: TypeDialogEditType.all,
      onSubmitPress: onSubmitPress,
    );
  }
}
