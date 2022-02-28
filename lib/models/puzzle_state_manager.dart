import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';

class PuzzleStateManager extends ChangeNotifier {
  bool? _darkMode = false;
  final List _menuItems = ['Simple', 'Custom'];
  int? _currentMenuIndex = 0;
  PuzzleState _puzzleState = const PuzzleState();
  final int? _size = 4;
  final Random? random = Random(2);

  bool get darkMode => _darkMode!;

  set darkMode(bool darkMode) {
    print('mode $darkMode');
    _darkMode = darkMode;

    notifyListeners();
  }

  List get menuItems => _menuItems;

  int get currentMenuIndex => _currentMenuIndex!;
  set currentMenuIndex(int currentMenuIndex) {
    _currentMenuIndex = currentMenuIndex;
    notifyListeners();
  }

  String get assetName => _darkMode!
      ? 'assets/images/logo_flutter_white.png'
      : 'assets/images/logo_flutter_color.png';

  PuzzleState get puzzleState => _puzzleState;

  void initilizePuzzle() {
    final timerSate = TimerStateManager();
    final puzzle = _generatePuzzle(_size!, shuffle: timerSate.shufflePuzzle);
    _puzzleState = PuzzleState(
      puzzle: puzzle.sort(),
      numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
    );
  }

  void resetPuzzle() {
    // final timerSate = TimerStateManager();
    final puzzle = _generatePuzzle(_size!);
    _puzzleState = PuzzleState(
      puzzle: puzzle.sort(),
      numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
    );
    notifyListeners();
  }

  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile posistions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  void onTileTapped(Tile tile) {
    print('yes tapped ${tile.value}');
    if (_puzzleState.puzzleStatus == PuzzleStatus.incomplete) {
      print('incomplete ${_puzzleState.puzzleStatus}');
      if (_puzzleState.puzzle.isTileMovable(tile)) {
        print('is movable tile ${_puzzleState.puzzle.isTileMovable(tile)}');
        final mutablePuzzle = Puzzle(tiles: [..._puzzleState.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tile, []);
        if (puzzle.isComplete()) {
          print('is complete ${puzzle.isComplete()}');
          _puzzleState.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: _puzzleState.numberOfMoves + 1,
              lastTappedTile: tile);
          notifyListeners();
        } else {
          print('is not complete');
          _puzzleState.copyWith(
            puzzle: puzzle.sort(),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
            numberOfMoves: _puzzleState.numberOfMoves + 1,
            lastTappedTile: tile,
          );
          notifyListeners();
        }
      } else {
        print('is not movable');
        _puzzleState.copyWith(
            tileMovementStatus: TileMovementStatus.cannotBeMoved);
        // notifyListeners();
      }
    } else {
      print('is incomplete');
      _puzzleState.copyWith(
          tileMovementStatus: TileMovementStatus.cannotBeMoved);
      // notifyListeners();
    }
  }
}
