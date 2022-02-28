import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:provider/provider.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzleState = Provider.of<PuzzleStateManager>(context, listen: false);
    final timerState = Provider.of<TimerStateManager>(context, listen: false);
    final buttonText = !timerState.timerStarted ? 'Start' : 'Reset';
    return PuzzleButton(
      isDisabled: false,
      textColor: PuzzleColors.white,
      backgroundColor:
          puzzleState.darkMode ? PuzzleColors.green50 : PuzzleColors.blue50,
      onPressed: () {
        timerState.stopwatch.isRunning ? puzzleState.resetPuzzle() : null;
        // Timer(
        //   const Duration(milliseconds: 3),
        //   () {
        //     Timer.periodic(const Duration(seconds: 1), (timer) {
        //       puzzleState.resetPuzzle();
        //     });
        //   },
        // );

        timerState.handleStartStop();
      },
      child: Text(buttonText),
    );
  }
}
