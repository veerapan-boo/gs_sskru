import 'package:flutter/material.dart';
import 'package:gs_sskru/models/title_link/title_link.dart';
import 'package:gs_sskru/util/constants.dart';

class KButtonOutlined extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color textColor;
  final Color? disabledColor;
  final bool enabled;
  final bool isLoading;
  final double paddingVertical;

  const KButtonOutlined({
    Key? key,
    this.text,
    this.onPressed,
    this.enabled = true,
    this.disabledColor,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.paddingVertical = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: paddingVertical),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(
                    color: Colors.red, width: 2, style: BorderStyle.solid),
              ),
            ),
          ),
          onPressed: enabled ? onPressed : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLoading)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              Text(
                text!,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: textTheme.subtitle1!.fontSize,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
