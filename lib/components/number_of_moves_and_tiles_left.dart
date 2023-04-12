import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:provider/provider.dart';

import '../themes/theme.dart';

class NumberOfMovesAndTilesLeft extends StatelessWidget {
  const NumberOfMovesAndTilesLeft({
    Key? key,
    required this.numberOfMoves,
    required this.numberOfTilesLeft,
    this.color,
  }) : super(key: key);

  final int numberOfMoves;

  final int numberOfTilesLeft;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);
    return ResponsiveLayout(
      mobile: (context, child) => Center(child: child),
      tablet: (context, child) => Center(child: child),
      desktop: (context, child) => child!,
      child: () {
        return Row(
          mainAxisAlignment: ResponsiveLayout.isDesktop(context)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AnimatedDefaultTextStyle(
              style: !state.darkMode
                  ? PuzzleTheme.lightTextTheme.headline6!
                  : PuzzleTheme.darkTextTheme.headline6!,
              duration: const Duration(milliseconds: 1000),
              child: Text('${numberOfMoves.toString()} Moves |'),
            ),
            AnimatedDefaultTextStyle(
              style: !state.darkMode
                  ? PuzzleTheme.lightTextTheme.headline6!
                  : PuzzleTheme.darkTextTheme.headline6!,
              duration: const Duration(milliseconds: 1000),
              child: Text('${numberOfTilesLeft.toString()} Tiles'),
            ),
          ],
        );
      },
    );
  }
}
