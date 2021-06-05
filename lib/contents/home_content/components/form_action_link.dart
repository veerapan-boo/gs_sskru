import 'package:flutter/material.dart';
import 'package:gs_sskru/components/buttons/k_button.dart';
import 'package:gs_sskru/components/buttons/k_button_outlined.dart';
import 'package:gs_sskru/components/input_text/k_input_field.dart';
import 'package:gs_sskru/util/constants.dart';

// ignore: must_be_immutable
class FormActionLink extends StatefulWidget {
  FormActionLink({
    Key? key,
    required this.inputWidth,
    required this.labelText,
    required this.linkText,
    this.closeText,
    this.submitText,
    required this.onClosePress,
    required this.onSubmitPress,
    required this.textController,
    required this.linkController,
    required this.isLoading,
  }) : super(key: key);
  final double inputWidth;
  final String labelText;
  final String linkText;
  String? closeText;
  String? submitText;
  final Function() onClosePress;
  final Function() onSubmitPress;
  final bool isLoading;
  TextEditingController? textController;
  TextEditingController? linkController;

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
  late Function() _onSubmitPress;

  @override
  void initState() {
    super.initState();
    _textController = widget.textController!;
    _linkController = widget.linkController!;
    _inputWidth = widget.inputWidth;
    _labelText = widget.labelText;
    _linkText = widget.linkText;
    _closeText = widget.closeText ?? 'ยกเลิก';
    _submitText = widget.submitText ?? 'บันทึก';
    _onClosePress = widget.onClosePress;
    _onSubmitPress = widget.onSubmitPress;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _inputWidth,
      child: Column(
        children: [
          KInputField(
            controller: _textController,
            labelText: _labelText,
          ),
          KInputField(
            controller: _linkController,
            labelText: _linkText,
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
