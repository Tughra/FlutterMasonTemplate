import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';

class FilterButton extends _Button {
  const FilterButton.general({super.key, super.buttonHeight, super.onTap,required String title,required IconData iconData}) : super(isApply: false,iconData: iconData,title: title);
  const FilterButton.apply({super.key, super.buttonHeight, super.onTap}) : super(isApply: true);
  const FilterButton.reset({super.key, super.buttonHeight, super.onTap}) : super(isApply: false);
}

abstract class _Button extends StatelessWidget {
  final double buttonHeight;
  final bool isApply;
  final IconData? iconData;
  final String? title;
  final void Function()? onTap;

  const _Button({Key? key, required this.isApply, this.buttonHeight = 54, this.onTap,this.iconData,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double textSize = (buttonHeight.clamp(24, 44)) * .3;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(ButtonRadius.middle),
      child: InkWell(
        borderRadius: BorderRadius.circular(ButtonRadius.middle),
        onTap: onTap,
        child: SizedBox(
          child: DecoratedBox(
            decoration:
                BoxDecoration(color: Colors.transparent, border: Border.all(width: 1, color: Theme.of(context).secondaryHeaderColor), borderRadius: BorderRadius.circular(ButtonRadius.middle)),
            child: Padding(
              padding: EdgeInsets.all(textSize * .5),
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconData ?? (isApply ? Icons.check : Icons.refresh),
                    color: Theme.of(context).primaryColor,
                    size: textSize * 1.5,
                  ),
                  4.widthIntMargin,
                  Text(
                    title ?? (isApply ? "Uygula" : "Sıfırla"),
                    style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: textSize),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
