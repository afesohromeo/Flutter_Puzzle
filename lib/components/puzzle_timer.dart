import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:flutter_puzzle/themes/puzzle_theme.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PuzzleTimer extends StatefulWidget {
  /// {@macro dashatar_timer}
  const PuzzleTimer(
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
  State<PuzzleTimer> createState() => _PuzzleTimerState();
}

class _PuzzleTimerState extends State<PuzzleTimer> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);

    final timerState = Provider.of<TimerStateManager>(context, listen: false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerState.stopwatch.isRunning) {
        setState(() {});
      } else {
        setState(() {});
      }
    });

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   print(timerState.stopwatch.elapsed.inSeconds);
    //   if (!timerState.stopwatch.isRunning) {
    //     timer.cancel();
    //   }
    //   timerState.rebuild();
    // });
    return ResponsiveLayout(
      mobile: (_, child) => child!,
      tablet: (_, child) => child!,
      desktop: (_, child) => child!,
      child: () {
        final currentTextStyle = widget.textStyle ??
            (ResponsiveLayout.isMobile(context)
                ? !state.darkMode
                    ? PuzzleTheme.lightTextTheme.headline2
                    : PuzzleTheme.darkTextTheme.headline2
                : !state.darkMode
                    ? PuzzleTheme.lightTextTheme.headline2!
                        .copyWith(fontSize: 40)
                    : PuzzleTheme.darkTextTheme.headline2!
                        .copyWith(fontSize: 40));

        final currentIconSize = widget.iconSize ??
            (ResponsiveLayout.isMobile(context)
                ? const Size(28, 28)
                : const Size(32, 32));
        final iconColor =
            state.darkMode ? PuzzleColors.white : PuzzleColors.black;

        final timeElapsed = timerState.stopwatch.elapsed;

        return Row(
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              style: currentTextStyle!,
              duration: const Duration(milliseconds: 1500),
              child: Text(
                _formatDuration(timeElapsed),
                key: ValueKey(timerState.secondsElapsed),
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
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
