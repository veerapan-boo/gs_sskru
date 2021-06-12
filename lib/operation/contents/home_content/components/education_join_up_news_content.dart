import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_link.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class EducationJoinUp extends StatelessWidget {
  final ImageProvider _image = AssetImage(
    'assets/images/education.png',
  );

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Container(
      constraints: BoxConstraints(maxWidth: kMaxWidth),
      margin: EdgeInsets.symmetric(vertical: 26),
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child: Row(
        mainAxisAlignment:
            isDesktop ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isDesktop)
            Container(
              width: kMaxWidth * .25,
              height: kMaxWidth * .25,
              decoration: BoxDecoration(image: DecorationImage(image: _image)),
            ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ข่าวรับสมัคร',
                  style: context.textTheme.headline4,
                ),
                KDialogEdit(
                  child: Text(
                    'อยู่ระหว่างการพัฒนาอยู่ระหว่างการพัฒนา...',
                    style: context.textTheme.headline6,
                  ),
                  type: DialogEditType.titleOnly(
                    title: 'อยู่ระหว่างการพัฒนาอยู่ระหว่างการพัฒนา',
                  ),
                ),
                SizedBox(height: 4),
                KDialogEdit(
                  child: KTextLink(
                    text: 'ดูเพิ่มเติม',
                    arrowIcon: true,
                    onPressed: () {},
                  ),
                  type: DialogEditType.linkOnly(link: 'ดูเพิ่มเติม'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
