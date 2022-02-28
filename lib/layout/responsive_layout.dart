import 'package:flutter/material.dart';

typedef ResponsiveWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayout extends StatelessWidget {
  final ResponsiveWidgetBuilder mobile;
  final ResponsiveWidgetBuilder tablet;
  final ResponsiveWidgetBuilder desktop;

  const ResponsiveLayout(
      {Key? key,
      required this.mobile,
      required this.tablet,
      required this.desktop,
      this.child})
      : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 528;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1235 &&
      MediaQuery.of(context).size.width >= 530;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1235;

  final Widget Function()? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = MediaQuery.of(context).size;

        if (size.width <= 528) {
          return mobile(context, child?.call());
        } else if (size.width <= 1235 && size.width > 528) {
          return tablet(context, child?.call());
        } else {
          return desktop(context, child?.call());
        }
      },
    );
  }
}
