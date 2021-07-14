import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gs_sskru/components/k_launchURL.dart';
import 'package:gs_sskru/controllers/contact_controller.dart';
import 'package:gs_sskru/data/data_contact.dart';
import 'package:gs_sskru/models/contact_model.dart';
import 'package:gs_sskru/operation/posters/home_poster/components/contact_on_hove.dart';
import 'package:gs_sskru/util/constants.dart';

class ContactDesktop extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding * .75,
            horizontal: kDefaultPadding * 2.5,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(
              color: kPrimaryColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: Colors.white,
                  size: context.textTheme.subtitle2!.fontSize,
                ),
              ),
              Text(
                phoneNumber,
                style: context.textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: kDefaultPadding),
        Obx(() {
          final ContactModel? facebook = controller.getListSocials
              .firstWhere((e) => e.id == '0', orElse: () => ContactModel());
          return ContactOnHove(
            onTap: () {
              k_launchURL(url: facebook?.link ?? notFound);
            },
            widget: Container(
              padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding * .75,
                horizontal: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                      size: context.textTheme.subtitle2!.fontSize,
                    ),
                  ),
                  Text(
                    "สำหนักงานบัญฑิตศึกษา",
                    style: context.textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            widgetOnHove: Container(
              padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding * .75,
                horizontal: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: kPrimaryColor,
                      size: context.textTheme.subtitle2!.fontSize,
                    ),
                  ),
                  Text(
                    "สำหนักงานบัญฑิตศึกษา",
                    style: context.textTheme.subtitle1!.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
