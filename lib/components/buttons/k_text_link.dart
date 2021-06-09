import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/util/constants.dart';

class KTextLink extends StatefulWidget {
  const KTextLink(
      {Key? key,
      this.textSize,
      this.text = '',
      this.arrowIcon = false,
      this.colors,
      required this.onPressed,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  final String text;
  final double? textSize;
  final bool arrowIcon;
  final Color? colors;
  final Function()? onPressed;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  _KTextLinkState createState() => _KTextLinkState();
}

class _KTextLinkState extends State<KTextLink> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment!,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              decoration:
                  _isHover ? TextDecoration.underline : TextDecoration.none,
              decorationColor: widget.colors ?? kPrimaryColor,
              decorationThickness: 1,
              color: widget.colors ?? kPrimaryColor,
              fontSize:
                  widget.textSize ?? context.textTheme.subtitle1!.fontSize,
              height: 0,
            ),
          ),
          if (widget.arrowIcon)
            Container(
              padding: EdgeInsets.only(
                  top: (widget.textSize ??
                          context.textTheme.subtitle1!.fontSize!) *
                      .011),
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                color: widget.colors ?? kPrimaryColor,
                size:
                    (widget.textSize ?? context.textTheme.subtitle1!.fontSize!),
              ),
            )
        ],
      ),
    );
  }
}
