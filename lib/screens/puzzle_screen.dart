// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/screens/screens.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:flutter_puzzle/components/components.dart';

import 'custom/puzzle_custom.dart';
import 'simple/puzzle_simple.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({Key? key}) : super(key: key);

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Consumer<PuzzleStateManager>(
                  builder: (context, appStateManager, child) {
                return Column(
                  children: [buildHeader(), buildBody()],
                );
              })),
        );
      }),
    ));
  }

  Widget buildHeader() {
    return AnimatedContainer(
      constraints: const BoxConstraints(maxHeight: 100),
      duration: const Duration(milliseconds: 600),
      child: ResponsiveLayout(
        mobile: (context, child) => Stack(
          children: [
            Align(
              child: PuzzleLogo(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: DarkModeSwitcher(
                  darkMode:
                      Provider.of<PuzzleStateManager>(context, listen: false)
                          .darkMode,
                  // push: (value) {
                  //   Provider.of<PuzzleStateManager>(context, listen: false)
                  //       .darkMode = value;
                  // },
                ),
              ),
            ),
          ],
        ),
        tablet: (context, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [PuzzleLogo(), PuzzleMenu()],
          ),
        ),
        desktop: (context, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [PuzzleLogo(), PuzzleMenu()],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    final index = Provider.of<PuzzleStateManager>(context, listen: false)
        .currentMenuIndex;
    return LazyLoadIndexedStack(
      index: index,
      children: [
        PuzzleSimple(),
        PuzzleCustom(),
      ],
    );
  }
}



