import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_button.dart';
import 'package:gs_sskru/components/input_text/k_input_field.dart';
import 'package:gs_sskru/components/toast/toast.dart';
import 'package:gs_sskru/controllers/user_controller.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class ContentLogin extends StatefulWidget {
  @override
  _ContentLoginState createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserController _userController = Get.put(UserController());

  // Loading button
  bool _isLoading = false;

  void _eventLoad() {
    setState(() => _isLoading = !_isLoading);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Obx(() => Text(_userController.getUser.value.name)),
            KInputField(
              controller: _emailController,
              hintText: 'อีเมลเจ้าหน้าที่',
            ),
            KInputField(
              obscureText: true,
              controller: _passwordController,
              hintText: 'รหัสผ่าน',
            ),
            KButton(
              isLoading: _isLoading,
              text: 'เข้าสู่ระบบ',
              onPressed: () => _onLogin(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            ),
            // KButton(
            //   isLoading: _isLoading,
            //   text: 'อัพเดท',
            //   onPressed: () => _userController.,
            //   // onPressed: () => _onLogin(
            //   //   email: _emailController.text,
            //   //   password: _passwordController.text,
            //   // ),
            // )
          ],
        ),
      ),
    );
  }

  void _onLogin({required String email, required String password}) async {
    _eventLoad();
    // FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      // UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // User? user = _userCredential.user;

      // print(user?.refreshToken);
      // User user = _userController.getUser;
    } on FirebaseAuthException catch (e) {
      print(e.code.characters.string);
      String msg = 'กรุณาตรวจสอบข้อมูลและลองใหม่อีกครั้ง';
      switch (e.code.characters.string) {
        case 'invalid-email':
          toast('รูปแบบอีเมลไม่ถูกต้อง', msg);
          break;
        case 'user-not-found':
          toast('ไม่พบอีเมลนี้ในฐานข้อมูล', msg);
          break;
        case 'wrong-password':
          toast('รหัสผ่านไม่ถูกต้อง', msg);
          break;
        default:
      }
      _eventLoad();
    }
  }
}
