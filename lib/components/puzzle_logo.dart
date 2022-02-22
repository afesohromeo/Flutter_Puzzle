import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/puzzle_state_manager.dart';
import 'package:provider/provider.dart';

import '../layout/responsive_layout.dart';

class PuzzleLogo extends StatelessWidget {
  const PuzzleLogo({Key? key, required this.imageAsset}) : super(key: key);

  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    print(
        "darkmode state ${Provider.of<PuzzleStateManager>(context, listen: false).darkMode}");

  
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: ResponsiveLayout(
          mobile: (context, child) => Image.asset(
           imageAsset!,
            height: 24,
          ),
          tablet: (context, child) => Image.asset(
            imageAsset!,
            height: 29,
          ),
          desktop: (context, child) => Image.asset(
            imageAsset!,
            height: 32,
          ),
        ),
      );
    
  }
}
