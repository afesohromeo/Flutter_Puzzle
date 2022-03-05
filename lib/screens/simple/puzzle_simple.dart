// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/model.dart';

class PuzzleSimple extends StatelessWidget {
  const PuzzleSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, child) => Column(
        children: [
          PuzzleMenu(),
          StartSection(),
          BoardSection(),
        ],
      ),
      tablet: (context, child) => Column(
        children: [StartSection(), BoardSection(), EndSection()],
      ),
      desktop: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: StartSection()),
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
      child: () => SimpleStartSection(),
    );
  }
}

class BoardSection extends StatelessWidget {
  const BoardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('my board');
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
            return PuzzleBoard(
                size: 4,
                tiles: board.puzzleState.puzzle.tiles
                    .map((tile) => PuzzleTile(
                          tile: tile,
                        ))
                    .toList());
          }),
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

class SimpleStartSection extends StatelessWidget {
  const SimpleStartSection({Key? key}) : super(key: key);

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
