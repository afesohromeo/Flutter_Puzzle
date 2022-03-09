import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:flutter_puzzle/themes/puzzle_theme.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PuzzleTimer extends StatelessWidget {
  /// {@macro dashatar_timer}
  PuzzleTimer(
      {Key? key,
      this.textStyle,
      this.iconSize,
      this.iconPadding,
      this.mainAxisAlignment,
      required this.isRunning})
      : super(key: key);

  /// The optional [TextStyle] of this timer.
  final TextStyle? textStyle;

  /// The optional icon [Size] of this timer.
  final Size? iconSize;

  /// The optional icon padding of this timer.
  final double? iconPadding;

  /// The optional [MainAxisAlignment] of this timer.
  /// Defaults to [MainAxisAlignment.center] if not provided.
  final MainAxisAlignment? mainAxisAlignment;

  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);

    final currentTextStyle = textStyle ??
        (ResponsiveLayout.isMobile(context)
            ? !state.darkMode
                ? PuzzleTheme.lightTextTheme.headline2
                : PuzzleTheme.darkTextTheme.headline2
            : !state.darkMode
                ? PuzzleTheme.lightTextTheme.headline2!.copyWith(fontSize: 40)
                : PuzzleTheme.darkTextTheme.headline2!.copyWith(fontSize: 40));

    final currentIconSize = iconSize ??
        (ResponsiveLayout.isMobile(context)
            ? const Size(28, 28)
            : const Size(32, 32));
    final iconColor = state.darkMode ? PuzzleColors.white : PuzzleColors.black;

    return Consumer<TimerStateManager>(builder: (context, timer, child) {
      final timeElapsed = timer.stopwatch.elapsed;

      return Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
            style: currentTextStyle!,
            duration: const Duration(milliseconds: 1500),
            child: Text(
              _formatDuration(timeElapsed),
              key: ValueKey(timer.secondsElapsed),
            ),
          ),
          Gap(10),
          AnimatedSwitcher(
            duration: const Duration(microseconds: 600),
            child: Icon(
              Icons.timer_outlined,
              color: iconColor,
              size: currentIconSize.width,
            ),
          )
        ],
      );
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
