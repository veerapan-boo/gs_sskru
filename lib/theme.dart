import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_sskru/util/constants.dart';

Theme themeBuilder(BuildContext context, Widget? child) {
  // Google font style
  styleText(textStyle, {Color? color}) {
    return GoogleFonts.prompt(
      textStyle: textStyle,
      fontWeight: FontWeight.w300,
      color: color ?? Colors.black87,
    );
  }

  var text = context.textTheme;
  return Theme(
    data: ThemeData(
      fontFamily: 'Prompt',
      canvasColor: Colors.white,
      accentColor: kPrimaryColor,
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        headline2: styleText(
          context.responsiveValue(
            desktop: text.headline2,
            tablet: text.headline4,
            mobile: text.headline5,
          ),
        ),
        headline4: styleText(
          context.responsiveValue(
            desktop: text.headline4!,
            tablet: text.headline4!,
            mobile: text.subtitle2!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        headline5: styleText(
          context.responsiveValue(
            desktop: text.headline5,
            tablet: text.headline6,
            mobile: text.subtitle1,
          ),
        ),
        headline6: styleText(
          context.responsiveValue(
            desktop: text.headline6,
            tablet: text.subtitle1,
            mobile: text.bodyText1,
          ),
        ),
        subtitle1: styleText(text.subtitle1),
        subtitle2: styleText(text.subtitle2, color: Colors.black54),
        bodyText1: styleText(text.bodyText1, color: Colors.black54),
        bodyText2: styleText(text.bodyText2, color: Colors.black54),
        caption: styleText(text.caption, color: Colors.black54),
      ),
    ),
    child: child!,
  );
}
