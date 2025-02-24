import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';


class GlobalPaddingBody extends StatelessWidget {
  final Widget child;
  final bool hasHorizontal;
  final bool hasBottom;
  const GlobalPaddingBody(
      {super.key,
      required this.child,
      this.hasHorizontal = false,
      this.hasBottom = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            right: hasHorizontal ? AppPadding.standardMinBody : 0,
            left: hasHorizontal ? AppPadding.standardMinBody : 0,
            bottom: hasBottom ? 64 : 0),
        child: child);
  }
}
class BottomCurved extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const BottomCurved({super.key, required this.child,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              color: Colors.black.withValues(alpha: .5),
              offset: const Offset(0.0, 2),
              blurRadius: 5,
              spreadRadius: 2
          )],
          color: backgroundColor??Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(ButtonRadius.middle),topRight: Radius.circular(ButtonRadius.middle))),
      child: child,
    );
  }
}
