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
    // print('Building tile');
    final state = Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final timerState = Provider.of<TimerStateManager>(context, listen: false);
    final buttonStyle = !darkMode
        ? PuzzleTheme.lightTextTheme.headline6!
            .copyWith(fontSize: ResponsiveLayout.isMobile(context) ? 25 : 40)
        : PuzzleTheme.darkTextTheme.headline6!
            .copyWith(fontSize: ResponsiveLayout.isMobile(context) ? 25 : 40);
    final bgColor = !darkMode
        ? PuzzleColors.bluePrimary.withOpacity(0.9)
        : PuzzleColors.green50;
    // print("wansass ${timerState.timerStarted}");

    return AnimatedContainer(
        // alignment: FractionalOffset(
        //   (tile.currentPosition.x - 1) / (3),
        //   (tile.currentPosition.y - 1) / (3),
        // ),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        // child: SizedBox.square(
        //     dimension: 130,
        child:
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     elevation: 4,
            //     animationDuration: const Duration(milliseconds: 600),
            //     shape: const RoundedRectangleBorder(),
            //     padding: const EdgeInsets.symmetric(),
            //     primary: PuzzleColors.white,
            //   ),
            //   clipBehavior: Clip.hardEdge,
            //   onPressed: timerState.timerStarted
            //       ? () {
            //           state.onTileTapped(tile);
            //         }
            //       : null,
            //   child: Text(
            //     tile.value.toString(),
            //   ),
            // ),

            AnimatedTextButton(
          duration: const Duration(milliseconds: 600),
          style: TextButton.styleFrom(
            primary: PuzzleColors.white,
            textStyle: buttonStyle,
            backgroundColor: bgColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(19),
              ),
            ),
          ).copyWith(
            foregroundColor: MaterialStateProperty.all(PuzzleColors.white),
          ),
          onPressed: timerState.timerStarted
              ? () {
                  state.onTileTapped(tile);
                }
              : null,
          child: Text(
            tile.value.toString(),
          ),
        )
        // )
        );
  }
}
