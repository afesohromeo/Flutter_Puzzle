import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';

class ImageTileBuider extends StatefulWidget {
  const ImageTileBuider({Key? key, required this.tile, required this.image})
      : super(key: key);
  final Tile tile;
  final Image image;

  @override
  State<ImageTileBuider> createState() => _ImageTileBuiderState();
}

class _ImageTileBuiderState extends State<ImageTileBuider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final timerState = Provider.of<TimerStateManager>(context, listen: false);
    return AnimatedAlign(
      alignment: FractionalOffset(
        (widget.tile.currentPosition.x - 1) / (3),
        (widget.tile.currentPosition.y - 1) / (3),
      ),
      duration: const Duration(milliseconds: 600),
      curve: Curves.bounceIn,
      child: ResponsiveLayout(
        mobile: (context, child) => SizedBox.square(
          dimension: 80,
          child: child,
        ),
        tablet: (context, child) => SizedBox.square(
          dimension: 100,
          child: child,
        ),
        desktop: (context, child) => SizedBox.square(
          dimension: 115,
          child: child,
        ),
        child: () =>
            // AnimatedContainer(
            //     curve: Curves.fastOutSlowIn,
            //     duration: const Duration(milliseconds: 500),
            //     decoration: const BoxDecoration(
            //       // borderRadius: BorderRadius.circular(20),
            //       // image: DecorationImage(
            //       //   image: AssetImage(imageAsset),
            //       //   fit: BoxFit.fill,
            //       // ),
            //       shape: BoxShape.rectangle,
            //     ),
            //     child: image),

            ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: timerState.timerStarted
                  ? () {
                      state.onTileTapped(widget.tile);
                    }
                  : null,
              icon: widget.image),
        ),
      ),
    );
  }
}
