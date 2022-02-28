import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
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
    final isRunning = Provider.of<TimerStateManager>(context, listen: false)
        .stopwatch
        .isRunning;

    return PuzzleButton(
      isDisabled: isRunning,
      textColor: puzzleState.darkMode
          ? isRunning
              ? PuzzleColors.white.withOpacity(0.5)
              : PuzzleColors.white
          : PuzzleColors.white,
      backgroundColor: puzzleState.darkMode
          ? isRunning
              ? PuzzleColors.green50
              : PuzzleColors.green50
          : isRunning
              ? PuzzleColors.blue50.withOpacity(0.5)
              : PuzzleColors.blue50,
      onPressed: () {
        isRunning ? null : puzzleState.resetPuzzle();
      },
      child: const Text('Shuffle'),
    );
  }
}
