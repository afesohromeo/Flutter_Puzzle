import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class ImageTileBuider extends StatelessWidget {
  const ImageTileBuider({Key? key, required this.tile, required this.image})
      : super(key: key);
  final Tile tile;
  final Image image;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final timerState = Provider.of<TimerStateManager>(context, listen: false);
    return AnimatedAlign(
      alignment: FractionalOffset(
        (tile.currentPosition.x - 1) / (3),
        (tile.currentPosition.y - 1) / (3),
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      child: ResponsiveLayout(
        mobile: (context, child) => SizedBox.square(
          dimension: 80,
          child: child,
        ),
        tablet: (context, child) => SizedBox.square(
          dimension: 100,
          child: child,
        ),
        desktop: (context, child) => SizedBox.square(
          dimension: 115,
          child: child,
        ),
        child: () => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: timerState.timerStarted
                  ? () {
                      state.onTileTapped(tile);
                    }
                  : null,
              icon: image),
        ),
      ),
    );
  }
}
