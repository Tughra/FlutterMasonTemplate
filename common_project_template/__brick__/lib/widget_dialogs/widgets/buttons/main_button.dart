import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';

enum MainBtnShape { rounded, bevel }

class MainButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Color? titleColor;
  final FontWeight? titleWeight;
  final Widget? iconLeft;
  final Widget? iconRight;
  final Color? color;
  final bool hasIndicator;
  final bool hasPadding;
  final MainBtnShape buttonShape;
  final double? buttonHeight;
  final FlexFit textFlexFit;

  const MainButton(
      {super.key,
        this.onPressed,
        this.title,
        this.iconLeft,
        this.iconRight,
        this.color,
        this.hasIndicator = false,
        this.titleWeight,
        this.titleColor,
        this.buttonHeight,
        this.textFlexFit=FlexFit.loose,
        this.buttonShape = MainBtnShape.rounded,
        this.hasPadding = false});

  BorderRadius shapeTurn(double width) {
    final size = _buttonMaxHeight(buttonHeight, deviceWidth: width);
    switch (buttonShape) {
      case MainBtnShape.bevel:
        return BorderRadius.only(
            bottomLeft: Radius.circular(size), topRight: Radius.circular(size), bottomRight: const Radius.circular(4), topLeft: const Radius.circular(4));
      case MainBtnShape.rounded:
        return BorderRadius.circular((size*.3));
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (_,constraint){
      final width = constraint.maxWidth;
      return Padding(
        padding: hasPadding == true ? EdgeInsets.symmetric(horizontal: context.buttonPadding) : EdgeInsets.zero,
        child: MaterialButton(
          height: _buttonMaxHeight(buttonHeight, deviceWidth: width),
          splashColor: Colors.white,
          highlightColor: Colors.lime,
          onPressed: hasIndicator ? null : onPressed,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledColor: Theme.of(context).colorScheme.secondary,
          color: hasIndicator ? Theme.of(context).colorScheme.secondary : color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: shapeTurn(width)),
          child: SizedBox(
            width: hasPadding == true ? double.maxFinite:null,
            height: _buttonMaxHeight(_buttonMaxHeight(buttonHeight, deviceWidth: width), deviceWidth: width),
            child: Row( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: _buttonMaxHeight(buttonHeight, deviceWidth: width),
                    height: _buttonMaxHeight(buttonHeight, deviceWidth: width),
                    child: Center(widthFactor: 1,heightFactor: 1,
                      child: hasIndicator
                          ? CupertinoActivityIndicator(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      )
                          : iconLeft,
                    ),
                  ),
                ),
                Flexible(
                  fit: textFlexFit,
                  child: Text(
                    title ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                        color: titleColor ?? Colors.white,
                        fontWeight: titleWeight,
                        fontSize: _titleMaxHeight(_buttonMaxHeight(buttonHeight, deviceWidth: width), deviceWidth: width)),
                  ),
                ),
                SizedBox(
                  width: _buttonMaxHeight(buttonHeight, deviceWidth: width),
                  height: _buttonMaxHeight(buttonHeight, deviceWidth: width),
                  child: Center(widthFactor: 1,heightFactor: 1,child: iconRight),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

double _buttonMaxHeight(double? value, {required double deviceWidth}) {
  if (value == null) return 50;
  final bool isTabletWidth = deviceWidth.isTabletWidth;
  if (isTabletWidth) return value > 60 ? 60 : value;
  return value > 50 ? 50 : value;
}

double _titleMaxHeight(double value, {required double deviceWidth}) {
  final bool isTabletWidth = deviceWidth.isTabletWidth;
  if (isTabletWidth) return value * .5 > 18 ? 18 : value * .5;
  return value * .5 > 16 ? 16 : value * .5;
}