import 'package:flutter/material.dart';

class AnimatedTextButton extends ImplicitlyAnimatedWidget {
  const AnimatedTextButton({
    Key? key,
    required this.child,
    required this.style,
    required this.onPressed,
    required Duration duration,
    Curve curve = Curves.linear,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Widget child;

  final VoidCallback? onPressed;

  final ButtonStyle style;

  @override
  AnimatedWidgetBaseState<AnimatedTextButton> createState() =>
      _AnimatedTextButtonState();
}

class _AnimatedTextButtonState
    extends AnimatedWidgetBaseState<AnimatedTextButton> {
  ButtonStyleTween? _style;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _style = visitor(
      _style,
      widget.style,
      (dynamic value) => ButtonStyleTween(begin: value as ButtonStyle),
    ) as ButtonStyleTween?;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _style!.evaluate(animation),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

class ButtonStyleTween extends Tween<ButtonStyle> {
  ButtonStyleTween({ButtonStyle? begin, ButtonStyle? end})
      : super(begin: begin, end: end);

  @override
  ButtonStyle lerp(double t) => ButtonStyle.lerp(begin, end, t)!;
}
