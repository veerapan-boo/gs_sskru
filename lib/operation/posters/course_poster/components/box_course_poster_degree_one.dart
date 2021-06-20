import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/buttons/k_text_button.dart';
import 'package:gs_sskru/components/k_dialog_edit.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';

class BoxCoursePosterDegreeOne extends StatelessWidget {
  BoxCoursePosterDegreeOne({
    Key? key,
    required this.data,
    required this.title,
    required this.context,
  })  : _imageOne = AssetImage('assets/images/book1.png'),
        super(key: key);

  final List data;
  final TitleLinkModel title;
  final BuildContext context;

  final ImageProvider _imageOne;

  @override
  Widget build(BuildContext context) {
    double deadlineDateSize = context.responsiveValue(
      desktop: 16,
      tablet: 14,
      mobile: 14,
    )!;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 90),
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _imageOne,
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                    Colors.white24,
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 210,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: kDefaultPadding),
              Text(
                "หลักสูตรระดับปริญญาโท",
                style: context
                    .responsiveValue(
                        desktop: context.textTheme.headline5,
                        tablet: context.textTheme.headline5,
                        mobile: context.textTheme.headline6)
                    ?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              KDialogEdit(
                direction: DirectionDialogEdit.forCenter,
                type: DialogEditType.linkOnly(
                    link: /*TODO*/ "TODO",
                    onSubmitPress: (link) {
                      // TODO:
                    }),
                child: KTextButton(
                  onPressed: () => k_launchURL(url: /*TODO*/ ""),
                  text: 'ดูเพิ่มเติม',
                  mainAxisAlignment: MainAxisAlignment.center,
                  textSize: deadlineDateSize,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
