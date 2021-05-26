import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class KButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color textColor;
  final Color? disabledColor;
  final bool enabled;
  final bool isLoading;

  const KButton({
    Key? key,
    this.text,
    this.onPressed,
    this.enabled = true,
    this.disabledColor,
    this.isLoading = false,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            disabledColor: kDisabledPrimaryColor,
            padding: EdgeInsets.symmetric(vertical: 29, horizontal: 36),
            color: kPrimaryColor,
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                          kPrimaryColor.withOpacity(
                            .75,
                          ),
                        ),
                      ),
                    ),
                  ),
                Text(
                  text!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textTheme.subtitle1!.fontSize,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
