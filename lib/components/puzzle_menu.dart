import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../layout/responsive_layout.dart';
import '../models/puzzle_state_manager.dart';

class PuzzleMenu extends StatelessWidget {
  const PuzzleMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          Provider.of<PuzzleStateManager>(context, listen: false)
              .menuItems
              .length,
          (index) => PuzzleMenuItem(
            menuIndex: index,
            menuItem: Provider.of<PuzzleStateManager>(context, listen: false)
                .menuItems[index],
          ),
        ),
        ResponsiveLayout(
          mobile: (_, child) => const SizedBox(),
          tablet: (_, child) => child!,
          desktop: (_, child) => child!,
          child: () {
            return Row(
              children: [
                const Gap(40),
                DarkModeSwitcher(
                  darkMode:
                      Provider.of<PuzzleStateManager>(context, listen: false)
                          .darkMode,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}