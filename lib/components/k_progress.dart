import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class KProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(
          kPrimaryColor,
        ),
      ),
    );
  }
}
