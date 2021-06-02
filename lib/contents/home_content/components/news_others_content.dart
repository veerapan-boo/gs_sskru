import 'package:flutter/material.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class NewsOthersContent extends StatelessWidget {
  final double height = kDefaultPadding * 25;
  @override
  Widget build(BuildContext context) {
    final double kSizeWidth = Responsive.kSizeWidth(context);
    final double contentWidth =
        (kSizeWidth < kMaxWidth ? kSizeWidth / 2 : kMaxWidth / 2) -
            kDefaultPadding;

    List<Widget> _listWidget = [
      BoxNews(
        contentWidth: contentWidth,
        title: 'ข่าวนักศึกษา',
        // Todo
        data: [],
      ),
      SizedBox(width: kDefaultPadding),
      BoxNews(
        contentWidth: contentWidth,
        title: 'ข่าวทุนวิจัย',
        // Todo
        data: [],
      ),
    ];

    return Container(
      width: kMaxWidth < kSizeWidth ? kMaxWidth : kSizeWidth,
      child: LimitedBox(
        maxHeight: height * 2,
        child: Responsive(
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _listWidget,
          ),
          mobile: Column(
            children: _listWidget,
          ),
          tablet: Column(
            children: _listWidget,
          ),
        ),
      ),
    );
  }
}

class BoxNews extends StatelessWidget {
  const BoxNews(
      {Key? key,
      required this.contentWidth,
      required this.title,
      required this.data})
      : super(key: key);

  final double contentWidth;
  final String title;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: contentWidth,
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 1.5),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (_, index) {
              return Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    InkWell(
                      hoverColor: Colors.grey[300],
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                width: contentWidth * .7,
                                child: Text(
                                  data[index]['text'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              data[index]['createDate'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Divider(height: 0, color: Colors.grey[300]),
                    ),
                    if (index + 1 == data.length) SizedBox(height: 30)
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
