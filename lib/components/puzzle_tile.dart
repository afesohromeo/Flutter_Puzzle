import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import 'components.dart';

class PuzzleTile extends StatelessWidget {
  const PuzzleTile({Key? key, required this.tile, required this.image}) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;
  final Image image;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);

    return tile.isWhitespace
        ?const  WhiteSpaceTileBuilder()
        : state.currentMenuIndex == 0
            ? NumberTileBuilder(
                tile: tile,
                darkMode: state.darkMode,
              )
            : ImageTileBuider(tile: tile, image: image);
  }
}
