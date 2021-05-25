import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double specing = 26.0;
    return SliverToBoxAdapter(
      child: Container(
        height: kDefaultPadding * 27,
        color: kDarkBlackColor.withOpacity(.9),
        padding: EdgeInsets.all(kDefaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('ข่าว'),
                      subTitle('ข่าวทุนวิจัย'),
                      subTitle('ข่าวนักศึกษา'),
                      subTitle('ข่าวรับสมัคร'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('เกี่ยวกับบัญฑิต'),
                      subTitle('วิสัยทัศน์/พันธกิจ'),
                      subTitle('นโยบายมหาวิทยาลัย'),
                      subTitle('โครงสร้างองค์กร'),
                      subTitle('รายงานประจําปี'),
                      subTitle('งานประกันคุณภาพ'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('รับสมัครนักศึกษา'),
                      subTitle('ปริญญาโท'),
                      subTitle('ปริญญาเอก'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('หลักสูตร'),
                      subTitle('หลักสูตรระดับปริญญาเอก'),
                      subTitle('หลักสูตรระดับปริญญาโท'),
                      subTitle('ขั้นตอนการจัดทำหลักสูตร'),
                      subTitle('มคอ.2'),
                      subTitle('ระเบียบ/ประกาศเกี่ยวกับหลักสูตร'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('บริการด้านวิชาการ'),
                      subTitle('วิจัยและบริการวิชาการ'),
                      subTitle('วารสารวิชาการ'),
                      subTitle('ฐานข้อมูลการวิจัย'),
                      subTitle(
                          'งานบริการวิชาการ กิจกรรมต่างๆ ที่จัดให้นักศึกษา'),
                      subTitle('ระเบียบ/ประกาศเกี่ยวกับหลักสูตร'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('บริการด้านอื่น ๆ'),
                      subTitle('ปฏิทินนักศึกษา'),
                      subTitle('ข้อบังคับ/ประกาศหลักเกณฑ์'),
                      subTitle('ระเบียบ/ประกาศการเงิน'),
                      subTitle('คู่มือการทําวิทยานิพนธ์'),
                      subTitle('ดาวน์โหลดใบคําร้อง'),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 80,
              color: Colors.white24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('Staff'),
                      subTitle('ผู้บริหารและบุคลากร'),
                      subTitle('คณะกรรมการบริหารหลักสูตรโทและเอก'),
                      subTitle('คณะกรรมการอำนวนการ'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle('Follow Up'),
                      Icon(
                        Icons.facebook,
                        color: Colors.white60,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container headTitle(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextButton subTitle(String text) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          text,
          style: TextStyle(color: Colors.white60),
        ),
      ),
    );
  }
}
