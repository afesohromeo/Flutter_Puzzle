import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzleState = Provider.of<PuzzleStateManager>(context, listen: false);

    final puzzleBoardState =
        Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final isRunning = Provider.of<TimerStateManager>(context, listen: false)
            .stopwatch
            .isRunning ||
        puzzleBoardState.puzzleState.puzzleStatus == PuzzleStatus.complete;

    return PuzzleButton(
      isDisabled: isRunning,
      textColor: puzzleState.darkMode
          ? isRunning ||
                  (Provider.of<TimerStateManager>(context, listen: false)
                      .gettingReady) ||
                  (Provider.of<TimerStateManager>(context, listen: false)
                      .succesful)
              ? PuzzleColors.white.withOpacity(0.5)
              : PuzzleColors.white
          : PuzzleColors.white,
      backgroundColor: puzzleState.darkMode
          ? isRunning ||
                  (Provider.of<TimerStateManager>(context, listen: false)
                      .gettingReady)
              ? PuzzleColors.green50
              : PuzzleColors.green50
          : isRunning ||
                  (Provider.of<TimerStateManager>(context, listen: false)
                      .gettingReady)
              ? PuzzleColors.blue50.withOpacity(0.5)
              : PuzzleColors.blue50,
      onPressed: () {
        isRunning ? null : puzzleBoardState.resetPuzzle(true, true);
      },
      child: const Text('Shuffle'),
    );
  }
}
