import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/navbar_menu_controller.dart';
import 'package:gs_sskru/controllers/service_controller.dart';
import 'package:gs_sskru/data/data_contact.dart';
import 'package:gs_sskru/models/service_model.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/util/constants.dart';
import 'package:gs_sskru/util/responsive.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final _serviceController = Get.find<ServiceController>();
  final _navBarMenuController = Get.find<NavBarMenuController>();

  final double specing = 10.0;

  final _titleLink = TitleLinkModel().getValue.data;

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
        height: kDefaultPadding * 34,
        color: kDarkBlackColor.withOpacity(.9),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
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

    List<List<ServiceModel>> _listService = [
      _serviceController.getAcademic,
      _serviceController.getOther,
      _serviceController.getStaff
    ];

    List<Widget> list = [SizedBox(), SizedBox(), SizedBox(), SizedBox()];
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? kDefaultPadding * 4 : kDefaultPadding,
      ),
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (var i = 1; i <= _titleLink!.length - 1; i++)
                ExpandableNotifier(
                  initialExpanded: false,
                  child: ExpandablePanel(
                    key: UniqueKey(),
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: false,
                      iconColor: Colors.white60,
                    ),
                    header: headTitle(_titleLink![i].headTitle),
                    collapsed: SizedBox(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...list,
                        // จำนวน 3 ชุดแรกของ data_type
                        if (i <= 3) ...{
                          for (var x = 0;
                              x <= _titleLink![i].subTitle.length - 1;
                              x++) ...{
                            subTitle(
                                text: _titleLink![i].subTitle[x].text,
                                onPressed: () {
                                  _navBarMenuController.setSelectedIndex(i);
                                })
                          }
                        } else ...{
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var elem in _listService[i - 4]) ...{
                                  subTitle(
                                      text: elem.text!,
                                      onPressed: () {
                                        k_launchURL(url: elem.link ?? "");
                                      }),
                                }
                              ],
                            ),
                          )
                        },
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
                )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headTitle('ติดต่อ'),
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
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "มหาวิทยาลัยราชภัฏศรีสะเกษ © 2021",
                style: TextStyle(
                  color: Colors.white70,
                ),
              )
            ],
          )
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
          children: [
            for (var i = 0; i <= 3; i++) ...{
              Container(
                padding: EdgeInsets.symmetric(horizontal: specing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headTitle(_titleLink![i].headTitle),
                    for (var elem in _titleLink![i].subTitle)
                      subTitle(
                        text: elem.text,
                        onPressed: () =>
                            _navBarMenuController.setSelectedIndex(i),
                      ),
                  ],
                ),
              )
            },
            Obx(
              () => Container(
                width: kMaxWidth / 5,
                padding: EdgeInsets.symmetric(horizontal: specing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headTitle(_titleLink![4].headTitle),
                    for (var elem in _serviceController.getAcademic)
                      subTitle(
                        text: elem.text!,
                        onPressed: () => k_launchURL(url: elem.link ?? ""),
                      ),
                  ],
                ),
              ),
            )
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
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: specing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headTitle(_titleLink![5].headTitle),
                        for (var elem in _serviceController.getOther)
                          subTitle(
                            text: elem.text!,
                            onPressed: () => k_launchURL(url: elem.link ?? ""),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: kMaxWidth / 5,
                    padding: EdgeInsets.symmetric(horizontal: specing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headTitle(_titleLink![6].headTitle),
                        for (var elem in _serviceController.getStaff)
                          subTitle(
                            text: elem.text!,
                            onPressed: () => k_launchURL(url: elem.link ?? ""),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: specing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headTitle('ติดต่อ'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            k_launchURL(url: facebookLink);
                          },
                          child: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white60,
                          ),
                        ),
                        SizedBox(width: kDefaultPadding),
                        FaIcon(
                          FontAwesomeIcons.line,
                          color: Colors.white60,
                        ),
                        SizedBox(width: kDefaultPadding),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        // * Copyright
        Divider(
          height: 80,
          color: Colors.white24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "มหาวิทยาลัยราชภัฏศรีสะเกษ © 2021",
              style: TextStyle(
                color: Colors.white70,
              ),
            )
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

  TextButton subTitle({required String text, Function()? onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
      onPressed: onPressed ?? () {},
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
