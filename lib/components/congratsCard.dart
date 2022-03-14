// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/puzzle_state.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../themes/theme.dart';

class CongratsCard extends StatelessWidget {
  const CongratsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);

    final textStyle = ResponsiveLayout.isDesktop(context)
        ? !state.darkMode
            ? PuzzleTheme.lightTextTheme.headline1!.copyWith(fontSize: 38)
            : PuzzleTheme.darkTextTheme.headline1!
                .copyWith(fontSize: 38, color: PuzzleColors.green90)
        : ResponsiveLayout.isTablet(context)
            ? !state.darkMode
                ? PuzzleTheme.lightTextTheme.headline1!.copyWith(fontSize: 35)
                : PuzzleTheme.darkTextTheme.headline1!
                    .copyWith(fontSize: 35, color: PuzzleColors.green90)
            : ResponsiveLayout.isMobile(context)
                ? !state.darkMode
                    ? PuzzleTheme.lightTextTheme.headline1!
                        .copyWith(fontSize: 22.5)
                    : PuzzleTheme.darkTextTheme.headline1!
                        .copyWith(fontSize: 22.5, color: PuzzleColors.green90)
                : null;
    final Size size = MediaQuery.of(context).size;
    return RepaintBoundary(
      child: Card(
        shape: CircleBorder(),
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 50, right: 50, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PuzzleLogo(),
              AnimatedDefaultTextStyle(
                style: textStyle!,
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'Congratulations',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedDefaultTextStyle(
                style: textStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: state.darkMode
                        ? PuzzleColors.white
                        : PuzzleColors.black),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'You have successfully solved the puzzle',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
