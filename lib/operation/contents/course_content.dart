import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/util/constants.dart';

class CourseContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth * .75),
      margin: EdgeInsets.only(bottom: kDefaultPadding * 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ขั้นตอนการจัดทำหลักสูตร',
                    style: context.textTheme.headline5,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'รายละเอียดของหลักสูตร (มคอ.2) การอธิบายภาพรวมของการจัดหลักสูตร การจัดการเรียนการสอน ที่จะทําให้บัณฑิตบรรลุผล การเรียนรู้ของหลักสูตร ซึ่งถ่ายทอดมาจากกรอบ มาตรฐานคุณวุฒิระดับอุดมศึกษาแห่งชาติ หรือ จากมาตรฐานคุณวุฒิสาขาวิชา',
                    style: context.textTheme.subtitle1
                        ?.copyWith(color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  KTextLink(
                    text: 'ดูเพิ่มเติม',
                    arrowIcon: true,
                    textSize: context.textTheme.subtitle1!.fontSize,
                    colors: kPrimaryColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'มคอ.2',
                    style: context.textTheme.headline5,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'รายละเอียดของหลักสูตร (มคอ.2) การอธิบายภาพรวมของการจัดหลักสูตร การจัดการเรียนการสอน ที่จะทําให้บัณฑิตบรรลุผล การเรียนรู้ของหลักสูตร ซึ่งถ่ายทอดมาจากกรอบ มาตรฐานคุณวุฒิระดับอุดมศึกษาแห่งชาติ หรือ จากมาตรฐานคุณวุฒิสาขาวิชา',
                    style: context.textTheme.subtitle1
                        ?.copyWith(color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  KTextLink(
                    text: 'ดูเพิ่มเติม',
                    arrowIcon: true,
                    textSize: context.textTheme.subtitle1!.fontSize,
                    colors: kPrimaryColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ระเบียบ/ประกาศเกี่ยวกับหลักสูตร',
                    style: context.textTheme.headline5,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'รายละเอียดของหลักสูตร (มคอ.2) การอธิบายภาพรวมของการจัดหลักสูตร การจัดการเรียนการสอน ที่จะทําให้บัณฑิตบรรลุผล การเรียนรู้ของหลักสูตร ซึ่งถ่ายทอดมาจากกรอบ มาตรฐานคุณวุฒิระดับอุดมศึกษาแห่งชาติ หรือ จากมาตรฐานคุณวุฒิสาขาวิชา',
                    style: context.textTheme.subtitle1
                        ?.copyWith(color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  KTextLink(
                    text: 'ดูเพิ่มเติม',
                    arrowIcon: true,
                    textSize: context.textTheme.subtitle1!.fontSize,
                    colors: kPrimaryColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
