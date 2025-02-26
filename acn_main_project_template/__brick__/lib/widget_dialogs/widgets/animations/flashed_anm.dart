import 'package:flutter/material.dart';

class FlashAnimation extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  const FlashAnimation({Key? key,required this.child,this.duration}) : super(key: key);

  @override
  State<FlashAnimation> createState() => _FlashAnimationState();
}

class _FlashAnimationState extends State<FlashAnimation>with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> opacityAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 1500),
      value: 0,
      upperBound: 1.0,
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {

        });
        animationController.reverse();
      } else if(status == AnimationStatus.dismissed){
        animationController.forward();
      }
    });
    animationController.forward();

  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child:  widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child:child,
        );
      },
    );
  }
}

