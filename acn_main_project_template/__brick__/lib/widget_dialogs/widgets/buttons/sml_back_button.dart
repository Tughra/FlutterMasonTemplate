import 'package:{{project_file_name}}/core/functions/global_functions.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomBackButton extends StatelessWidget {
  final double? size;
  final void Function()? whenPop;
  final bool shouldPop;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;

  const CustomBackButton({Key? key, this.iconColor, this.whenPop, this.backgroundColor, this.size, this.icon, this.shouldPop = true}) : super(key: key);

  closeKeyboard(BuildContext context) {
    if (isKeyboardOpen()) FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = maxScreenWidth(context.width);
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(maxWidth*.02),
      child: SizedBox(
        height: size ?? maxWidth * .1,
        width: size ?? maxWidth * .08,
        child: IconButton(
            splashRadius: maxWidth * .1,
            onPressed: () {
              closeKeyboard(context);
              whenPop?.call();
              if (shouldPop) Get.back();
            },
            icon:FittedBox(
              fit: BoxFit.none,
              child: Icon(
                icon ?? Icons.arrow_back_ios_sharp,
                color: iconColor ?? Colors.white,
              ),
            )),
      ),
    );
  }
}
