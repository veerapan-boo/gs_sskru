import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_button.dart';
import 'package:gs_sskru/components/buttons/k_button_outlined.dart';
import 'package:gs_sskru/components/input_text/k_input_field.dart';
import 'package:gs_sskru/util/constants.dart';

// ignore: must_be_immutable
class FormActionLink extends StatefulWidget {
  FormActionLink({
    Key? key,
    required this.type,
    required this.inputWidth,
    this.closeText,
    this.submitText,
    required this.onClosePress,
    // required this.onSubmitPress,
    required this.isLoading,
  }) : super(key: key);

  final double inputWidth;
  String? closeText;
  String? submitText;
  FormActionLinkType type;
  final Function() onClosePress;
  final bool isLoading;

  @override
  _FormActionLinkState createState() => _FormActionLinkState();
}

class _FormActionLinkState extends State<FormActionLink> {
  late TextEditingController _textController;
  late TextEditingController _linkController;
  late double _inputWidth;
  late String _labelText;
  late String _linkText;
  late String _closeText;
  late String _submitText;
  late Function() _onClosePress;
  late dynamic Function()? _onSubmitPress;
  late TypeFormActionLink _type;

  @override
  void initState() {
    super.initState();
    _inputWidth = widget.inputWidth;
    _onClosePress = widget.onClosePress;
    _closeText = widget.closeText ?? 'ยกเลิก';
    _submitText = widget.submitText ?? 'บันทึก';
    _onSubmitPress = widget.type.onSubmitPress;
    _type = widget.type.type!;

    switch (widget.type.type) {
      case TypeFormActionLink.titleOnly:
        _labelText = widget.type.title!;
        _textController = widget.type.textController!;
        break;
      case TypeFormActionLink.linkOnly:
        _linkText = widget.type.link!;
        _linkController = widget.type.linkController!;
        break;
      case TypeFormActionLink.all:
        _labelText = widget.type.title!;
        _linkText = widget.type.link!;
        _textController = widget.type.textController!;
        _linkController = widget.type.linkController!;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _inputWidth,
      child: Column(
        children: [
          if (_type == TypeFormActionLink.all ||
              _type == TypeFormActionLink.titleOnly)
            KInputField(
              controller: _textController,
              hintText: _labelText,
              icon: Icons.text_fields,
            ),
          if (_type == TypeFormActionLink.all ||
              _type == TypeFormActionLink.linkOnly)
            KInputField(
              controller: _linkController,
              hintText: _linkText,
              icon: Icons.link,
              hintStyle:
                  context.textTheme.subtitle2!.copyWith(color: kPrimaryColor),
            ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: KButtonOutlined(
                  text: _closeText,
                  onPressed: _onClosePress,
                ),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 1,
                child: KButton(
                  text: _submitText,
                  isLoading: widget.isLoading,
                  onPressed: _onSubmitPress,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum TypeFormActionLink { titleOnly, linkOnly, all }

class FormActionLinkType {
  FormActionLinkType({
    this.link,
    this.title,
    this.type,
    this.textController,
    this.linkController,
    this.onSubmitPress,
  });
  final String? link;
  final String? title;
  final TypeFormActionLink? type;
  final Function()? onSubmitPress;
  TextEditingController? textController;
  TextEditingController? linkController;

  factory FormActionLinkType.titleOnly({
    required String title,
    required TextEditingController textController,
    required Function() onSubmitPress,
  }) {
    return FormActionLinkType(
      title: title,
      type: TypeFormActionLink.titleOnly,
      textController: textController,
      onSubmitPress: onSubmitPress,
    );
  }
  factory FormActionLinkType.linkOnly({
    required String link,
    required TextEditingController linkController,
    required Function() onSubmitPress,
  }) {
    return FormActionLinkType(
      link: link,
      type: TypeFormActionLink.linkOnly,
      linkController: linkController,
      onSubmitPress: onSubmitPress,
    );
  }
  factory FormActionLinkType.all({
    required String title,
    required String link,
    required TextEditingController textController,
    required TextEditingController linkController,
    required Function() onSubmitPress,
  }) {
    return FormActionLinkType(
      title: title,
      link: link,
      type: TypeFormActionLink.all,
      textController: textController,
      linkController: linkController,
      onSubmitPress: onSubmitPress,
    );
  }
}
