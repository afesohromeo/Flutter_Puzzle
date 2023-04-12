import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/puzzle_state_manager.dart';
import 'package:provider/provider.dart';

import '../layout/responsive_layout.dart';

class PuzzleLogo extends StatelessWidget {
  const PuzzleLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetName =
        Provider.of<PuzzleStateManager>(context, listen: false).assetName;
    final height = ResponsiveLayout.isMobile(context)
        ? 25.0
        : ResponsiveLayout.isTablet(context)
            ? 30.0
            : ResponsiveLayout.isDesktop(context)
                ? 35.0
                : null;

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: myAnimatedLogo(assetName, height!));
  }

  Widget myAnimatedLogo(String assetName, double height) {
    return ResponsiveLayout(
      mobile: (context, child) => child!,
      tablet: (context, child) => child!,
      desktop: (context, child) => child!,
      child: () => Image.asset(
        assetName,
        height: height,
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            child: child,
          );
        },
      ),
    );
  }
}
