// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PuzzleCustom extends StatelessWidget {
  const PuzzleCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, child) => Column(
        children: [PuzzleMenu(), StartSection(), BoardSection()],
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
    final puzzle = Provider.of<PuzzleStateManager>(context, listen: false)
        .puzzleState
        .puzzle;
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
          mobile: (context, child) => SizedBox.square(
            dimension: 300,
            child: PuzzleBoard(
                size: 4,
                tiles: puzzle.tiles
                    .map(
                      (tile) => PuzzleTile(
                        tile: tile,
                      ),
                    )
                    .toList()),
          ),
          tablet: (context, child) => SizedBox.square(
            dimension: 420,
            child: PuzzleBoard(
                size: 4,
                tiles: puzzle.tiles
                    .map(
                      (tile) => PuzzleTile(
                        key: Key('puzzle_tile_${tile.value.toString()}'),
                        tile: tile,
                      ),
                    )
                    .toList()),
          ),
          desktop: (context, child) => SizedBox.square(
            dimension: 470,
            child: PuzzleBoard(
                size: 4,
                tiles: puzzle.tiles.map((tile) {
                  return PuzzleTile(
                    key: Key('puzzle_tile_${tile.value.toString()}'),
                    tile: tile,
                  );
                }).toList()),
          ),
        ),
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
            ? 10
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
    return Container();
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
        NumberOfMovesAndTilesLeft(
          numberOfMoves: 2,
          numberOfTilesLeft: 15,
        ),
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
