import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:flutter_puzzle/themes/theme.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class PuzzleMenuItem extends StatelessWidget {
  const PuzzleMenuItem(
      {Key? key, required this.menuItem, required this.menuIndex})
      : super(key: key);

  final String? menuItem;
  final int menuIndex;

  @override
  Widget build(BuildContext context) {
    final puzzleState = Provider.of<PuzzleStateManager>(context, listen: false);

    final timerState = Provider.of<TimerStateManager>(context, listen: false);

    final currentMenuIndex = puzzleState.currentMenuIndex;
    final isCurrentMenu = menuIndex == currentMenuIndex;
    final textStyle = isCurrentMenu
        ? !puzzleState.darkMode
            ? PuzzleTheme.lightTextTheme.headline3!.copyWith(
                fontWeight: FontWeight.w700,
                color: PuzzleColors.blue50,
              )
            : PuzzleTheme.darkTextTheme.headline3!.copyWith(
                color: PuzzleColors.green90,
              )
        : !puzzleState.darkMode
            ? PuzzleTheme.lightTextTheme.headline3!
            : PuzzleTheme.darkTextTheme.headline3!.copyWith(
                color: PuzzleColors.white, fontWeight: FontWeight.normal);

    return ResponsiveLayout(
      mobile: (_, child) => Column(
        children: [
          Container(
            width: 100,
            height: 40,
            decoration: isCurrentMenu
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: !puzzleState.darkMode
                            ? PuzzleColors.bluePrimary
                            : PuzzleColors.white,
                      ),
                    ),
                  )
                : null,
            child: child,
          ),
        ],
      ),
      tablet: (_, child) => child!,
      desktop: (_, child) => child!,
      child: () {
        final leftPadding =
            menuIndex > 0 && !ResponsiveLayout.isMobile(context) ? 40.0 : 0.0;

        return Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ).copyWith(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              isCurrentMenu
                  ? null
                  : () {
                      timerState.timerStarted ? timerState.stopTimer() : null;
                      Provider.of<PuzzleBoardStateManager>(context,
                              listen: false)
                          .resetPuzzle(false);

                      puzzleState.currentMenuIndex = menuIndex;
                    }();
            },
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 600),
              style: textStyle,
              child: Text(menuItem!),
            ),
          ),
        );
      },
    );
  }
}
