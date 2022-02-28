import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class PuzzleControlButton extends StatelessWidget {
  const PuzzleControlButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerState = Provider.of<TimerStateManager>(context, listen: false);

    return Consumer<TimerStateManager>(
        builder: (context, timerStateManager, child) {
      return Row(
        mainAxisAlignment: ResponsiveLayout.isDesktop(context)
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [StartStopButton(), const Gap(10), ShuffleButton()],
      );
    });
  }
}
