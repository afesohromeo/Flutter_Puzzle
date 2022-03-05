import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import 'components.dart';

class PuzzleTile extends StatelessWidget {
  const PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  @override
  Widget build(BuildContext context) {
    // print('puzzle tiles building ${tile.value}');
    final state = Provider.of<PuzzleStateManager>(context, listen: false);

    return tile.isWhitespace
        ? WhiteSpaceTileBuilder()
        : state.currentMenuIndex == 0
            ? NumberTileBuilder(
                tile: tile,
                darkMode: state.darkMode,
              )
            : ImageTileBuider( tile: tile,);
  }
}
