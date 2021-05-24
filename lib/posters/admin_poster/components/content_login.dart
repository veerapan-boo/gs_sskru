import 'package:flutter/material.dart';
import 'package:gs_sskru/components/buttons/k_button.dart';
import 'package:gs_sskru/components/input_text/k_input_field.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class ContentLogin extends StatefulWidget {
  @override
  _ContentLoginState createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      print(usernameController.text);
    });
    passwordController.addListener(() {
      print(passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Container(
      height: kDefaultPadding * (isDesktop ? 20 : 15.5),
      width: kDefaultPadding * 24,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.02),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KInputField(
            controller: usernameController,
            hintText: 'อีเมลเจ้าหน้าที่',
          ),
          KInputField(
            obscureText: true,
            controller: passwordController,
            hintText: 'รหัสผ่าน',
          ),
          KButton(
            text: 'เข้าสู่ระบบ',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
