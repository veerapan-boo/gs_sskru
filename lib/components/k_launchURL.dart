import 'package:flutter/material.dart';
import 'package:gs_sskru/components/k_toast.dart';
import 'package:gs_sskru/data/link_others.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: non_constant_identifier_names
void k_launchURL({required String url}) async {
  await canLaunch(url)
      ? await launch(url)
      : kToast(
          'ไม่สามารถเข้าลิงค์นี้ได้',
          Row(
            children: [
              Text('กรุณาแจ้งไปยังผู้ดูแลระบบ'),
              SizedBox(
                width: 8,
              ),
              Text('Facebook โดยกดที่การแจ้งเตือนนี้'),
            ],
          ),
          onTap: (_) {
            k_launchURL(url: link_others['facebook']);
          },
        );
}
