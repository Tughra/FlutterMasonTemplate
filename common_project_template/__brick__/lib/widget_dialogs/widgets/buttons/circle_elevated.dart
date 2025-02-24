import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';

class CircleElevatedButton extends StatelessWidget {
  final Color? color;
  final bool hasBackground;
  final Widget? child;
  final double? elevation;
  final void Function()? onPressed;

  const CircleElevatedButton(
      {super.key,
      this.color,
      required this.child,
      this.onPressed,
      this.elevation,
      this.hasBackground = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ButtonSize.standardBigger,
        height: ButtonSize.standardBigger,
        decoration: BoxDecoration(
            color:
                hasBackground ? Theme.of(context).primaryColor : Colors.transparent,
            shape: BoxShape.circle),
        padding: EdgeInsets.zero,
        child: Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: elevation,
                  padding: EdgeInsets.zero,
                  backgroundColor: color ?? Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ButtonSize.standardBigger),
                  ),
                  maximumSize: const Size(
                      ButtonSize.standardBigger, ButtonSize.standardBigger),
                  minimumSize: const Size(
                      ButtonSize.standardBigger, ButtonSize.standardBigger),
                ),
                onPressed: onPressed,
                child: child)));
  }
}

/*
ElevatedButton(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,

          elevation: elevation,
          padding: EdgeInsets.zero,
          backgroundColor: color ?? context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size ?? 48),
          ),
          minimumSize: Size(size ?? 32, size ?? 32),
          maximumSize: Size(size ?? 32, size ?? 32),
        ),
        onPressed: onPressed,
        child: child);
 */
/*
InkWell(
        highlightColor: Colors.transparent,

        onTap: onPressed,
        child: child);
 */
