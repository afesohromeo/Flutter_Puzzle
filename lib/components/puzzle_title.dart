import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../themes/theme.dart';

class PuzzleTitle extends StatelessWidget {
  const PuzzleTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleStateManager>(context, listen: false);

    return ResponsiveLayout(
      mobile: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child!,
          ),
        ),
      ),
      tablet: (context, child) => Center(
        child: child,
      ),
      desktop: (context, child) => SizedBox(
        width: 300,
        child: child,
      ),
      child: () {
        final textStyle = ResponsiveLayout.isDesktop(context)
            ? !state.darkMode
                ? PuzzleTheme.lightTextTheme.headline1!.copyWith(fontSize: 38)
                : PuzzleTheme.darkTextTheme.headline1!.copyWith(fontSize: 38)
            : ResponsiveLayout.isTablet(context)
                ? !state.darkMode
                    ? PuzzleTheme.lightTextTheme.headline1!
                        .copyWith(fontSize: 35)
                    : PuzzleTheme.darkTextTheme.headline1!
                        .copyWith(fontSize: 35)
                : ResponsiveLayout.isMobile(context)
                    ? !state.darkMode
                        ? PuzzleTheme.lightTextTheme.headline1!
                            .copyWith(fontSize: 30)
                        : PuzzleTheme.darkTextTheme.headline1!
                            .copyWith(fontSize: 30)
                    : null;

        final textAlign = ResponsiveLayout.isMobile(context)
            ? TextAlign.center
            : TextAlign.left;

        return AnimatedDefaultTextStyle(
          style: textStyle!,
          duration: const Duration(milliseconds: 1500),
          child: Text(
            'Amazing Puzzle',
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
