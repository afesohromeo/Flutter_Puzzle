import 'package:flutter/material.dart';
import 'package:flutter_puzzle/components/components.dart';

import '../themes/theme.dart';

class PuzzleButton extends StatelessWidget {
  const PuzzleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    required this.isDisabled,
  }) : super(key: key);

  final Color? backgroundColor;

  final Color? textColor;

  final VoidCallback? onPressed;

  final Widget child;

  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 44,
      child: AnimatedTextButton(
        duration: const Duration(milliseconds: 1500),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: PuzzleTheme.darkTextTheme.headline2!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(textColor),
        ),
        onPressed: isDisabled! ? null :  onPressed,
        child: child,
      ),
    );
  }
}
