import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final double specing = 10.0;

  final TitleLinkModel _titleLink = TitleLinkModel().getValue;

  ExpandableController _expandableController = ExpandableController();

  @override
  void initState() {
    super.initState();
    _expandableController.addListener(() {
      print(_expandableController.expanded);
    });
  }

  @override
  void dispose() {
    _expandableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    return SliverToBoxAdapter(
      child: Container(
        height: kDefaultPadding * 30,
        color: kDarkBlackColor.withOpacity(.9),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                  constraints: BoxConstraints(maxWidth: kMaxWidth),
                  child:
                      isDesktop ? contentDesktop() : contentMobileAndTablet(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container contentMobileAndTablet() {
    bool isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isTablet ? kDefaultPadding * 4 : kDefaultPadding),
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              _titleLink.data!.length,
              (index) {
                return ExpandableNotifier(
                  initialExpanded: false,
                  child: ExpandablePanel(
                    key: UniqueKey(),
                    theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: false,
                        iconColor: Colors.white60),
                    header: headTitle(_titleLink.data![index].headTitle),
                    collapsed: SizedBox(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var subTitle in _titleLink.data![index].subTitle)
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {},
                            child: Container(
                              // width: kMaxWidth / 7,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                subTitle.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: Colors.white60),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(
                            crossFadePoint: 0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headTitle('Follow Up'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 26),
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 26),
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white60,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.line,
                    color: Colors.white60,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Column contentDesktop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: specing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headTitle(_titleLink.data![index].headTitle),
                  for (var elem in _titleLink.data![index].subTitle)
                    subTitle(elem.text),
                ],
              ),
            );
          }),
        ),
        Divider(
          height: 80,
          color: Colors.white24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(2, (index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: specing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitle(_titleLink.data![index + 5].headTitle),
                      for (var elem in _titleLink.data![index + 5].subTitle)
                        subTitle(elem.text),
                    ],
                  ),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: specing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headTitle('Follow Up'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white60,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white60,
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.line,
                          color: Colors.white60,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Container headTitle(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
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
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          text,
          style: context.textTheme.bodyText2!.copyWith(color: Colors.white60),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
