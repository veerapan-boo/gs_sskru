import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';

class ContactOnHove extends StatelessWidget {
  const ContactOnHove(
      {required Widget widget, required Widget widgetOnHove, this.onTap})
      : _widget = widget,
        _widgetOnHove = widgetOnHove;

  final Widget _widget;
  final Widget _widgetOnHove;
  final bool initialValue = false;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ValueBuilder(
        initialValue: initialValue,
        builder: (bool? value, Function(bool)? update) {
          return MouseRegion(
            onEnter: (_) => update!(true),
            onExit: (_) => update!(false),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.fastOutSlowIn,
              switchOutCurve: Curves.fastOutSlowIn,
              child: value ?? initialValue
                  ? Container(
                      key: ValueKey<int>(1),
                      child: _widgetOnHove,
                    )
                  : Container(
                      key: ValueKey<int>(2),
                      child: _widget,
                    ),
            ),
          );
        },
      ),
    );
  }
}
