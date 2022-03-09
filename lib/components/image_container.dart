import 'package:flutter/material.dart';
import 'package:flutter_puzzle/layout/responsive_layout.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:provider/provider.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {Key? key, required this.imageAsset, required this.imageIndex})
      : super(key: key);

  final String imageAsset;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    final puzzleBoardState =
        Provider.of<PuzzleBoardStateManager>(context, listen: false);
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
    return
        // Material(
        //   child: InkWell(
        //     onTap: () {},
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(20.0),
        //       child: Image.asset(imageAsset, width: 150.0, height: 150.0),
        //     ),
        //   ),
        // );
        InkWell(
      onTap: () {
        puzzleBoardState.currentAssetInex = imageIndex;
      },
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
        // height: isCurrentImageIndex ? activeSize : inActiveSize,
        width: isCurrentImageIndex ? activeSize : inActiveSize,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          // image: DecorationImage(
          //   image: AssetImage(imageAsset),
          //   fit: BoxFit.fill,
          // ),
          shape: BoxShape.rectangle,
        ),
        child: Image.asset(
          imageAsset,
          fit: BoxFit.fill,
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool wasSynchronouslyLoaded) {
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
    );
  }
}
