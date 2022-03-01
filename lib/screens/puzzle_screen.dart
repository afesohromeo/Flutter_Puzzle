// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:html';

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
  // static List<Widget> pages = <Widget>[
  //    puzzleSimple(),
  //   const puzzleCustom()
  //   // const GroceryScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    print("scafold");
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
            children: [const PuzzleLogo(), PuzzleMenu()],
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
    print('current menu index $index');
    return LazyLoadIndexedStack(
      index: index,
      children: [
        PuzzleSimple(),
        PuzzleCustom(),
      ],
    );
  }
}

// class Header extends StatelessWidget {
//   const Header({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print('header');
//     final state = PuzzleStateManager();
//     return Container(
//       constraints: const BoxConstraints(maxHeight: 100),
//       child: ResponsiveLayout(
//         mobile: (context, child) => Column(
//           children: [
//             Stack(
//               children: [
//                 Align(
//                   child: PuzzleLogo(
//                     darkMode: state.darkMode,
//                   ),
//                 ),
//                 const Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 35),
//                     child: DarkModeSwitcher(
//                         // darkMode: state.darkMode,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         tablet: (context, child) => Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 50,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               PuzzleLogo(
//                 darkMode: state.darkMode,
//               ),
//               const PuzzleMenu(),
//             ],
//           ),
//         ),
//         desktop: (context, child) => Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 50,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               PuzzleLogo(
//                 darkMode: state.darkMode,
//               ),
//               const PuzzleMenu(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class PuzzleMenu extends StatelessWidget {
//   const PuzzleMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final state = PuzzleStateManager();

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ...List.generate(
//           2,
//           (index) => PuzzleMenuItem(
//             menuIndex: index,
//             menuItem: menuItems[index],
//           ),
//         ),
//         ResponsiveLayout(
//           mobile: (_, child) => const SizedBox(),
//           tablet: (_, child) => child!,
//           desktop: (_, child) => child!,
//           child: () {
//             return Row(
//               children: [
//                 const Gap(40),
//                 DarkModeSwitcher(
//                   darkMode: state.darkMode,
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
