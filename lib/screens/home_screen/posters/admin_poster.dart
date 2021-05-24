import 'package:flutter/material.dart';
import 'package:gs_sskru/components/navbar/navbar.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class AdminPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.kSizeHeight(context) - NavBar().navBarHeight,
      color: Colors.white,
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'สำนักงานบัณฑิตศึกษา',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      Text(
                        'มหาวิทยาลัยราชภัฏศรีสะเกษ',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  height: kDefaultPadding * 20,
                  width: kDefaultPadding * 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.02),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
