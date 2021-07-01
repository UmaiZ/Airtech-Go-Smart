part of '../widgets.dart';

enum _AnimationProps { opacity, translateX }

class FadeInAnimation extends StatelessWidget {
  final int delay;
  final Widget child;

  FadeInAnimation(this.delay, {this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AnimationProps>()
      ..add(_AnimationProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(
        _AnimationProps.translateX,
        Tween(begin: 30.0, end: 0.0),
        Duration(milliseconds: 500),
        // Curves.fastOutSlowIn,
        Curves.easeIn,
      );

    return PlayAnimation<MultiTweenValues<_AnimationProps>>(
      delay: Duration(milliseconds: 200 * delay),
      duration: Duration(milliseconds: 500),
      tween: tween,
      child: child,
      // curve: ,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AnimationProps.opacity),
        child: Transform.translate(
          offset: Offset(0, value.get(_AnimationProps.translateX)),
          child: child,
        ),
      ),
    );
  }
}
