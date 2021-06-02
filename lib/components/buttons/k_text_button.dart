import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class KTextButton extends StatelessWidget {
  const KTextButton({
    Key? key,
    this.textSize = 20,
    this.text = '',
    this.arrowIcon = false,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final double textSize;
  final bool arrowIcon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: kPrimaryColor, fontSize: textSize, height: 0),
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
