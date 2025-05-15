import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Color? color;
  final Widget icon;
  final double size;
  const CircleIcon({super.key,required this.icon,this.color,this.size=40});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: color??Theme.of(context).primaryColor),
            shape: BoxShape.circle,
            color: (color??Theme.of(context).primaryColor).withOpacity(.2)),
        child: SizedBox(
          width: size,
          height: size,
          child: icon,
        ));
  }
}
class RectangleIcon extends StatelessWidget {
  final Color? color;
  final Widget icon;
  final double size;
  final BorderRadiusGeometry? borderRadius;
  const RectangleIcon({super.key,required this.icon,this.color,this.size=40,this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
            border: Border.all(width: 2, color: color??Theme.of(context).primaryColor),
            shape: BoxShape.rectangle,
            color: (color??Theme.of(context).primaryColor).withOpacity(.2)),
        child: SizedBox(
          width: size,
          height: size,
          child: icon,
        ));
  }
}