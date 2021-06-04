import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class KTextLink extends StatefulWidget {
  const KTextLink(
      {Key? key,
      this.textSize = 16,
      this.text = '',
      this.arrowIcon = false,
      required this.onPressed,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  final String text;
  final double textSize;
  final bool arrowIcon;
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
              decorationColor: kPrimaryColor,
              decorationThickness: 1,
              color: kPrimaryColor,
              fontSize: widget.textSize,
              height: 0,
            ),
          ),
          if (widget.arrowIcon)
            Container(
              padding: EdgeInsets.only(top: widget.textSize * .011),
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: widget.textSize * .9,
              ),
            )
        ],
      ),
    );
  }
}
