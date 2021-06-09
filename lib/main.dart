import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_sskru/bindings/operation_bindings.dart';
import 'package:gs_sskru/operation/operation.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load image
    precacheImage(AssetImage('assets/images/sskru_logo.png'), context);
    precacheImage(AssetImage('assets/images/pattern_new.png'), context);
    precacheImage(AssetImage('assets/images/education.png'), context);
    return GetMaterialApp(
      title: 'วิทยาลัยบัญฑิต | SSKRU',
      debugShowCheckedModeBanner: false,
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData(
            canvasColor: Colors.white,
            accentColor: kPrimaryColor,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              headline2: GoogleFonts.prompt(
                textStyle: context.responsiveValue(
                    desktop: context.textTheme.headline2!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                    tablet: context.textTheme.headline4!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                    mobile: context.textTheme.headline5!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              headline4: GoogleFonts.prompt(
                textStyle: context.responsiveValue(
                  desktop: context.textTheme.headline4!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                  tablet: context.textTheme.headline4!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                  mobile: context.textTheme.headline6!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              headline5: GoogleFonts.prompt(
                textStyle: context.responsiveValue(
                  desktop: context.textTheme.headline5!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                  tablet: context.textTheme.headline6!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                  mobile: context.textTheme.subtitle1!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              headline6: GoogleFonts.prompt(
                textStyle: context.responsiveValue(
                  desktop: context.textTheme.headline6!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                  tablet: context.textTheme.subtitle1!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                  mobile: context.textTheme.bodyText1!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                color: Colors.black54,
                fontWeight: FontWeight.w300,
              ),
              subtitle1: GoogleFonts.prompt(
                textStyle: context.textTheme.subtitle1,
                color: Colors.black87,
                fontWeight: FontWeight.w300,
              ),
              subtitle2: GoogleFonts.prompt(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                textStyle: context.textTheme.subtitle2,
              ),
              bodyText1: GoogleFonts.prompt(
                textStyle: context.textTheme.bodyText1!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
              ),
              bodyText2: GoogleFonts.prompt(
                textStyle: context.textTheme.bodyText2!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
              ),
              caption: GoogleFonts.prompt(
                textStyle: context.textTheme.caption!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
      initialRoute: Operation.routeName,
      initialBinding: OperationBindings(),
      getPages: [
        GetPage(
          name: Operation.routeName,
          page: () => Operation(),
        ),
      ],
    );
  }
}
