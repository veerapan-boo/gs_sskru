import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class KTextButton extends StatelessWidget {
  const KTextButton(
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
  final Function() onPressed;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            kPrimaryColor.withOpacity(.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment!,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    color: kPrimaryColor, fontSize: textSize, height: 0),
              ),
            ),
            if (arrowIcon)
              Container(
                padding: EdgeInsets.only(top: textSize * .011),
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: kPrimaryColor,
                  size: textSize * .9,
                ),
              )
          ],
        ),
      ),
    );
  }
}
