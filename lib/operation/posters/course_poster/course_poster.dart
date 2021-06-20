import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/models/title_link_model.dart';
import 'package:gs_sskru/operation/posters/course_poster/components/box_course_poster_degree_one.dart';
import 'package:gs_sskru/operation/posters/course_poster/components/box_course_poster_degree_two.dart';
import 'package:gs_sskru/util/constants.dart';

class CoursePoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = TitleLinkModel().getValue;
    var row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: BoxCoursePosterDegreeOne(
              data: [], title: title, context: context),
        ),
        SizedBox(
          height: 220,
          child: VerticalDivider(thickness: 1, color: Colors.grey[200]),
        ),
        Expanded(
          flex: 1,
          child: BoxCoursePosterDegreeTwo(
              data: [], title: title, context: context),
        ),
      ],
    );

    var column = Column(
      children: [
        BoxCoursePosterDegreeOne(data: [], title: title, context: context),
        SizedBox(
          height: 100,
          width: context.width - (kDefaultPadding * 2),
          child: Divider(
            thickness: 1,
            color: Colors.grey[200],
          ),
        ),
        BoxCoursePosterDegreeTwo(data: [], title: title, context: context)
      ],
    );

    return Container(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3.5),
      child: Column(
        children: [
          // Title
          Container(
            margin: EdgeInsets.only(
              top: context.responsiveValue(
                  desktop: kDefaultPadding * 4,
                  tablet: kDefaultPadding * 3,
                  mobile: kDefaultPadding * 3)!,
            ),
            child: Text(
              "หลักสูตร",
              style: context
                  .responsiveValue(
                    desktop: context.textTheme.headline4,
                    tablet: context.textTheme.headline4,
                    mobile: context.textTheme.headline4,
                  )
                  ?.copyWith(color: Colors.black87),
            ),
          ),
          SizedBox(height: kDefaultPadding * 3),
          // Content poster
          context.responsiveValue(
            desktop: Container(
              width: kMaxWidth,
              child: row,
            ),
            tablet: row,
            mobile: column,
          )!,
        ],
      ),
    );
  }
}
