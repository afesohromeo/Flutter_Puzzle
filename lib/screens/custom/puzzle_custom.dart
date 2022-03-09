// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PuzzleCustom extends StatelessWidget {
  const PuzzleCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, child) => Column(
        children: [PuzzleMenu(), StartSection(), BoardSection(), EndSection()],
      ),
      tablet: (context, child) => Column(
        children: [StartSection(), BoardSection(), EndSection()],
      ),
      desktop: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StartSection(),
          ),
          BoardSection(),
          Expanded(child: EndSection())
        ],
      ),
    );
  }
}

class StartSection extends StatelessWidget {
  const StartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, child) => child!,
      tablet: (context, child) => child!,
      desktop: (context, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child!,
      ),
      child: () => CustomStartSection(),
    );
  }
}

class BoardSection extends StatelessWidget {
  const BoardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(ResponsiveLayout.isMobile(context)
            ? 20
            : ResponsiveLayout.isTablet(context)
                ? 10
                : 30),
        PuzzleTimer(
          isRunning: Provider.of<TimerStateManager>(context, listen: false)
              .stopwatch
              .isRunning,
        ),
        Gap(ResponsiveLayout.isMobile(context)
            ? 10
            : ResponsiveLayout.isTablet(context)
                ? 10
                : 30),
        ResponsiveLayout(
            mobile: (context, child) =>
                SizedBox.square(dimension: 300, child: child),
            tablet: (context, child) => SizedBox.square(
                  dimension: 420,
                  child: child,
                ),
            desktop: (context, child) => SizedBox.square(
                  dimension: 470,
                  child: child,
                ),
            child: () => Consumer<PuzzleBoardStateManager>(
                    builder: (context, board, child) {
                  if (board.imageList.isEmpty) {
                    return FutureBuilder(
                        future: Provider.of<PuzzleBoardStateManager>(context,
                                listen: false)
                            .initCustomBoard(
                                Provider.of<PuzzleBoardStateManager>(context,
                                        listen: false)
                                    .currentAssetInex),
                        builder: (context, AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return PuzzleBoard(
                              size: 4,
                              tiles: board.puzzleState.puzzle.tiles
                                  .map((tile) => PuzzleTile(
                                        tile: tile,
                                        image: board.imageList[tile.value - 1],
                                      ))
                                  .toList(),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else {
                    return PuzzleBoard(
                      size: 4,
                      tiles: board.puzzleState.puzzle.tiles
                          .map((tile) => PuzzleTile(
                                tile: tile,
                                image: board.imageList[tile.value - 1],
                              ))
                          .toList(),
                    );
                  }
                })),
        Gap(ResponsiveLayout.isMobile(context)
            ? 20
            : ResponsiveLayout.isTablet(context)
                ? 30
                : 30),
        ResponsiveLayout(
          mobile: (context, child) => PuzzleControlButton(),
          tablet: (context, child) => PuzzleControlButton(),
          desktop: (context, child) => SizedBox(),
        ),
        Gap(ResponsiveLayout.isMobile(context)
            ? 30
            : ResponsiveLayout.isTablet(context)
                ? 30
                : 30),
      ],
    );
  }
}

class EndSection extends StatelessWidget {
  const EndSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzleBoardState =
        Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final puzzleState = Provider.of<PuzzleStateManager>(context, listen: false);
    final floatingButtonColor =
        puzzleState.darkMode ? PuzzleColors.green50 : PuzzleColors.blue50;
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 40, bottom: 10, right: 15),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Consumer<PuzzleBoardStateManager>(builder: (context, board, child) {
            return Padding(
              padding: EdgeInsets.only(top: 75),
              child: Wrap(spacing: 20, runSpacing: 20,
                  // alignment: WrapAlignment.end,
                  // runAlignment: WrapAlignment.end,
                  // crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    ...List.generate(
                        puzzleBoardState.imageAssets.length,
                        (index) => ImageContainer(
                              imageAsset: puzzleBoardState.imageAssets[index],
                              imageIndex: index,
                            ))
                  ]),
            );
          }),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              backgroundColor: floatingButtonColor,
              onPressed: () {},
              child: Icon(Icons.camera_alt, size: 20),
              tooltip: 'Upload an Image',
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStartSection extends StatelessWidget {
  const CustomStartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(ResponsiveLayout.isMobile(context)
            ? 20
            : ResponsiveLayout.isTablet(context)
                ? 30
                : 150),
        PuzzleTitle(),
        Gap(ResponsiveLayout.isMobile(context)
            ? 5
            : ResponsiveLayout.isTablet(context)
                ? 10
                : 30),
        Consumer<PuzzleBoardStateManager>(builder: (context, board, child) {
          return NumberOfMovesAndTilesLeft(
            numberOfMoves:
                Provider.of<PuzzleBoardStateManager>(context, listen: false)
                    .puzzleState
                    .numberOfMoves,
            numberOfTilesLeft:
                Provider.of<PuzzleBoardStateManager>(context, listen: false)
                    .puzzleState
                    .numberOfTilesLeft,
          );
        }),
        Gap(ResponsiveLayout.isMobile(context)
            ? 5
            : ResponsiveLayout.isTablet(context)
                ? 10
                : 30),
        ResponsiveLayout(
            mobile: (context, child) => const SizedBox(),
            tablet: (context, child) => const SizedBox(),
            desktop: (context, child) => PuzzleControlButton())
      ],
    );
  }
}
