import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:flutter_puzzle/themes/theme.dart';
import 'package:provider/provider.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {Key? key, required this.imageAsset, required this.imageIndex})
      : super(key: key);

  final Uint8List imageAsset;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    final puzzleBoardState =
        Provider.of<PuzzleBoardStateManager>(context, listen: false);
    final puzzleState = Provider.of<PuzzleStateManager>(context, listen: false);
    final isCurrentImageIndex = imageIndex == puzzleBoardState.currentAssetInex;
    final activeSize = ResponsiveLayout.isMobile(context)
        ? 100.0
        : ResponsiveLayout.isTablet(context)
            ? 150.0
            : ResponsiveLayout.isDesktop(context)
                ? 180.0
                : null;

    final inActiveSize = ResponsiveLayout.isMobile(context)
        ? 80.0
        : ResponsiveLayout.isTablet(context)
            ? 130.0
            : ResponsiveLayout.isDesktop(context)
                ? 155.0
                : null;
    return Tooltip(
        message: 'Swipe left to remove',
        child:
            // Material(
            //   child: InkWell(
            //     onTap: () {},
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Image.asset(imageAsset, width: 150.0, height: 150.0),
            //     ),
            //   ),
            // );
            AbsorbPointer(
          absorbing: isCurrentImageIndex ? true : false,
          child: Dismissible(
            key: Key(imageAsset.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              puzzleBoardState.deleteImage(imageIndex);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('image removed'),
                ),
              );
            },
            child: InkWell(
              onTap: () {
                isCurrentImageIndex
                    ? null
                    : puzzleBoardState.currentAssetInex = imageIndex;
              },
              child: AnimatedContainer(
                padding: const EdgeInsets.all(3),
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 500),
                height: isCurrentImageIndex ? activeSize : inActiveSize,
                width: isCurrentImageIndex ? activeSize : inActiveSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //   image: AssetImage(imageAsset),
                  //   fit: BoxFit.fill,
                  // ),
                  border: Border.all(
                      color: isCurrentImageIndex
                          ? !puzzleState.darkMode
                              ? (PuzzleColors.blue50)
                              : (PuzzleColors.green90)
                          : Colors.transparent,
                      width: 3.0),
                  shape: BoxShape.rectangle,
                ),
                clipBehavior: Clip.hardEdge,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    imageAsset,
                    fit: BoxFit.contain,
                    frameBuilder: (BuildContext context, Widget child,
                        int? frame, bool wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
