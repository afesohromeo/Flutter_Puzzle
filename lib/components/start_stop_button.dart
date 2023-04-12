import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:provider/provider.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzleState = Provider.of<PuzzleStateManager>(context, listen: false);

    final puzzleBoardState =
        Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final timerState = Provider.of<TimerStateManager>(context, listen: false);
    final buttonText = timerState.gettingReady
        ? 'Get Ready'
        : puzzleBoardState.puzzleState.puzzleStatus == PuzzleStatus.complete
            ? 'Restart'
            : !timerState.timerStarted
                ? 'Start'
                : 'Reset';
    return PuzzleButton(
      isDisabled: false,
      textColor: PuzzleColors.white,
      backgroundColor:
          puzzleState.darkMode ? PuzzleColors.green50 : PuzzleColors.blue50,
      onPressed: () {
        timerState.timerStarted
            ? () {
                timerState.handleStartStop();
                puzzleBoardState.resetPuzzle(true, false);
              }()
            : () {
                timerState.gettingReady = true;

                timerState.succesful
                    ? () {
                        puzzleBoardState.reStartPuzzle();

                        Timer(
                          const Duration(milliseconds: 1000),
                          () {
                            timerState.reset();
                            puzzleBoardState.getReady(timerState);
                          },
                        );
                      }()
                    : puzzleBoardState.getReady(timerState);
              }();

        // puzzleState.rebuild();
      },
      child: Text(buttonText),
    );
  }
}
