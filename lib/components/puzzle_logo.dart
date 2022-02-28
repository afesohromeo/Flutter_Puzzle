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

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: myAnimatedLogo(assetName));
  }

  Widget myAnimatedLogo(String assetName) {
    return ResponsiveLayout(
      mobile: (context, child) => Image.asset(
        assetName,
        height: 25,
      ),
      tablet: (context, child) => Image.asset(
        assetName,
        height: 30,
      ),
      desktop: (context, child) => Image.asset(
        assetName,
        height: 35,
      ),
    );
  }
}
