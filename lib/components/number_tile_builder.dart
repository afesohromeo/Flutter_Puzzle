import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../themes/theme.dart';

class NumberTileBuilder extends StatelessWidget {
  const NumberTileBuilder(
      {Key? key, required this.tile, required this.darkMode})
      : super(key: key);
  final Tile tile;
  final bool darkMode;

  /// The font size of the tile to be displayed.
  // final double tileFontSize;

  /// The state of the puzzle.

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);
    final buttonStyle = !darkMode
        ? PuzzleTheme.lightTextTheme.headline6!
            .copyWith(fontSize: ResponsiveLayout.isMobile(context) ? 25 : 40)
        : PuzzleTheme.darkTextTheme.headline6!
            .copyWith(fontSize: ResponsiveLayout.isMobile(context) ? 25 : 40);
    final bgColor = !darkMode
        ? PuzzleColors.bluePrimary.withOpacity(0.9)
        : PuzzleColors.green50;
    return AnimatedTextButton(
      duration: const Duration(milliseconds: 1500),
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: buttonStyle,
        backgroundColor: bgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      onPressed: () {
        state.onTileTapped(tile);
      },
      child: Text(
        tile.value.toString(),
      ),
    );
  }
}
