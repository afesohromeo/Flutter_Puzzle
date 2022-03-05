import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';
import 'package:provider/provider.dart';

class PuzzleBoardStateManager extends ChangeNotifier {
  PuzzleState _puzzleState = PuzzleState();
  final int? _size = 4;
  final Random? random = Random();

  PuzzleState get puzzleState => _puzzleState;

  void rebuild() {
    notifyListeners();
  }

  void initilizePuzzle() {
    final timerSate = TimerStateManager();
    final puzzle = _generatePuzzle(_size!, shuffle: timerSate.shufflePuzzle);
    _puzzleState = PuzzleState(
      puzzle: puzzle.sort(),
      numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
    );
  }

  void resetPuzzle(bool rebuild) {
    // final timerSate = TimerStateManager();
    final puzzle = _generatePuzzle(_size!);
    _puzzleState = PuzzleState(
      puzzle: puzzle.sort(),
      numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
    );
    rebuild ? notifyListeners() : null;
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
    print('yes tapped ${tile.value}, ${tile.currentPosition}');
    for (Tile t in _puzzleState.puzzle.tiles) {
      print('update ## ${t.value}');
    }
    if (_puzzleState.puzzleStatus == PuzzleStatus.incomplete) {
      print('incomplete ${_puzzleState.puzzleStatus}');
      if (_puzzleState.puzzle.isTileMovable(tile)) {
        print('is movable tile ${_puzzleState.puzzle.isTileMovable(tile)}');
        final mutablePuzzle = Puzzle(tiles: [..._puzzleState.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tile, []);

        if (puzzle.isComplete()) {
          print('is complete ${puzzle.isComplete()}');
          _puzzleState = _puzzleState.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: _puzzleState.numberOfMoves + 1,
              lastTappedTile: tile);
          notifyListeners();
        } else {
          print('is not complete');
          _puzzleState = _puzzleState.copyWith(
            puzzle: puzzle.sort(),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
            numberOfMoves: _puzzleState.numberOfMoves + 1,
            lastTappedTile: tile,
          );
          print(puzzle.sort() == null);
          for (Tile t in puzzle.sort().tiles) {
            print('update ${t.value}');
          }
          for (Tile t in _puzzleState.puzzle.tiles) {
            print('update # ${t.value}');
          }
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

  Future<void> getReady(TimerStateManager timerState) async {
    Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      print('tick ${timer.tick}, ${timer.tick == 3}');

      timer.tick == 4
          ? () {
              // timerState.gettingReady = false;

              timerState.handleStartStop();
              notifyListeners();

              timer.cancel();
            }()
          : resetPuzzle(true);
    });
  }
}
