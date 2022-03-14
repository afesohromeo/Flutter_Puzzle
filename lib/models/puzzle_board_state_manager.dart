import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';
import 'package:image/image.dart' as imglib;

class PuzzleBoardStateManager extends ChangeNotifier {
  PuzzleState _puzzleState = const PuzzleState();

  final List<Image> _imageList = <Image>[];
  final int? _size = 4;
  final Random? random = Random();
  List<Uint8List> imageAssets = <Uint8List>[];
  // [
  //   'assets/images/blue.png',
  //   'assets/images/yellow.png',
  //   'assets/images/green.png',
  //   'assets/images/blue.png',
  //   'assets/images/yellow.png',
  //   'assets/images/green.png',
  //   'assets/images/flutter dash.png',
  //   'assets/images/dash.jpg',
  // ];
  int? _currentAssetInex = 0;

  PuzzleState get puzzleState => _puzzleState;
  List<Image> get imageList => _imageList;

  int get currentAssetInex => _currentAssetInex!;
  set currentAssetInex(int currentAssetInex) {
    _currentAssetInex = currentAssetInex;
    _imageList.clear();
    print('index $_currentAssetInex');
    splitImage(currentAssetInex);

    notifyListeners();
  }

  void rebuild() {
    notifyListeners();
  }

  void initilizePuzzle() {
    final timerSate = TimerStateManager();
    final puzzle = _generatePuzzle(_size!, shuffle: timerSate.shufflePuzzle);
    _puzzleState = PuzzleState(
      puzzle: puzzle,
      numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
    );
    // await initImages();

    // await initCustomBoard(currentAssetInex);
  }

  void resetPuzzle(bool rebuild, bool sort) {
    // final timerSate = TimerStateManager();
    final puzzle = _generatePuzzle(_size!);
    _puzzleState = PuzzleState(
      puzzle: sort ? puzzle.sort() : puzzle,
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

      timer.tick >= 4
          ? () {
              // timerState.gettingReady = false;

              timerState.handleStartStop();
              notifyListeners();

              timer.cancel();
            }()
          : resetPuzzle(true, true);
    });
  }

  Future<void> splitImage(int index) async {
    // convert image to image from image package
    imglib.Image image = imglib.decodeImage(imageAssets[index])!;

    int x = 0, y = 0;
    int width = (image.width / 4).round();
    int height = (image.height / 4).round();
    image = imglib.copyCrop(image, 8, 8, image.width, image.height);

    // split image to parts
    List<imglib.Image> parts = <imglib.Image>[];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        parts.add(imglib.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    // convert image from image package to Image Widget to display
    for (var img in parts) {
      _imageList.add(Image.memory(
        Uint8List.fromList(
          imglib.encodeJpg(img),
        ),
        fit: BoxFit.fill,
        width: 120,
        height: 120,
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: child,
          );
        },
      ));
    }
  }

  Future<void> initCustomBoard(int index) async {
    splitImage(index);
    // notifyListeners();
  }

  void runinit() async {
    await initCustomBoard(currentAssetInex);
  }

  Future<void> initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    var assets = manifestMap.keys
        .where((String key) => key.startsWith('assets/images/custom'))
        .toList();
    print("list ${assets}");

    for (var element in assets) {
      var data = await rootBundle.load(element);
      imageAssets.add(data.buffer.asUint8List());
    }
  }

  void addImage(Uint8List imageData) async {
    imageAssets.add(imageData);
    currentAssetInex = imageAssets.indexOf(imageData);
    _imageList.clear();
    notifyListeners();
  }

  void deleteImage(int index) {
    print('index to delete $index');
    imageAssets.removeAt(index);
    if (currentAssetInex > index) {
      currentAssetInex -= 1;
    }
    notifyListeners();
  }
}
