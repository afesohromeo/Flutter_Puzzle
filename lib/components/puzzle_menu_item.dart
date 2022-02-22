import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:flutter_puzzle/themes/theme.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class PuzzleMenuItem extends StatelessWidget {
  const PuzzleMenuItem(
      {Key? key, required this.menuItem, required this.menuIndex})
      : super(key: key);

  final String? menuItem;
  final int menuIndex;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);
    final currentMenuIndex = state.currentMenuIndex;
    final isCurrentMenu = menuIndex == currentMenuIndex;

    print('current $isCurrentMenu');
    print(
        'menuitem $menuItem == currentMenu ${state.menuItems[currentMenuIndex]}');
    return ResponsiveLayout(
      mobile: (_, child) => Column(
        children: [
          Container(
            width: 100,
            height: 40,
            decoration: isCurrentMenu
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: !state.darkMode
                            ? PuzzleColors.bluePrimary
                            : PuzzleColors.white,
                      ),
                    ),
                  )
                : null,
            child: child,
          ),
        ],
      ),
      tablet: (_, child) => child!,
      desktop: (_, child) => child!,
      child: () {
        final leftPadding =
            menuIndex > 0 && !ResponsiveLayout.isMobile(context) ? 40.0 : 0.0;
        print('menuindex $menuIndex');

        print('left padding $leftPadding');

        return Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ).copyWith(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              print('item $menuItem');
              Provider.of<PuzzleStateManager>(context, listen: false)
                  .currentMenuIndex = menuIndex;
            },
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 500),
              style: isCurrentMenu
                  ? !state.darkMode
                      ? PuzzleTheme.lightTextTheme.headline3!
                      : PuzzleTheme.darkTextTheme.headline3!
                  : !state.darkMode
                      ? PuzzleTheme.lightTextTheme.headline4!
                      : PuzzleTheme.darkTextTheme.headline4!,
              child: Text(menuItem!),
            ),
          ),
        );
      },
    );
  }
}
