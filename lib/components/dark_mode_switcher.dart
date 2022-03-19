import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/themes/colors.dart';
import 'package:provider/provider.dart';

class DarkModeSwitcher extends StatelessWidget {
  const DarkModeSwitcher({Key? key, required this.darkMode}) : super(key: key);

  final bool? darkMode;

  @override
  Widget build(BuildContext context) {
   

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Switch(
          // activeColor: PuzzleColors.white,
          // activeTrackColor: PuzzleColors.white,
          value: darkMode!,
          onChanged: (value) {
            Provider.of<PuzzleStateManager>(context, listen: false).darkMode =
                value;
          },
        ));
  }
}
