import 'package:flutter/material.dart';

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
  }) : super(key: key);
  final int size;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    print('my puzzle grid board ');

    return
       
        GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: size,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: tiles
            // List<Widget>.generate(
            //     16,
            //     (index) => Center(
            //           child: Text("data"),
            //         )),
            );
  }
}
