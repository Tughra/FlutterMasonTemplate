import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/buttons/main_button.dart';

class LoadingDialog extends StatelessWidget {
  final Color? indicatorColor;
  final String? text;
  final bool? exitButton;
  final bool? hasBlur;

  const LoadingDialog(
      {Key? key, this.indicatorColor, this.text, this.exitButton, this.hasBlur})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: hasBlur == true ? 4.0 : 0,
            sigmaY: hasBlur == true ? 4.0 : 0),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 40, left: 40, bottom: 50),
                      child: Text(
                        text!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      )),
              CupertinoActivityIndicator(
                color: indicatorColor ?? context.theme.primaryColor,
                radius: 32,
              ),
              exitButton == true
                  ? MainButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      title: "Çıkış Yap",
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  static show({
    String? text,
    bool? exitButton,
    bool hasTimeOut = false,
    bool blurEffect = false,
    Color? backgroundColor,
    Color? indicatorColor,
  }) {
    Get.dialog(
            LoadingDialog(
                text: text,
                exitButton: exitButton,
                hasBlur: blurEffect,
                indicatorColor: indicatorColor),
            barrierColor: backgroundColor ?? Colors.black54,
            barrierDismissible: false,
            useSafeArea: true,
            routeSettings: const RouteSettings(name: "/LoadingDialog"))
        .timeout(const Duration(seconds: 4), onTimeout: () {
      if (hasTimeOut) {
        Get.back();
      }
    });
  }
  static showViaContext(BuildContext context) {
    showDialog(context: context, builder: (context) => const LoadingDialog(hasBlur: true,),useSafeArea: false,barrierColor: Colors.transparent);
  }

  static closeViaContext(BuildContext context) {
    Navigator.pop(context);
  }
  static closeViaLastRoot(String rootName) {
    Get.until((route) => Get.currentRoute == rootName);
  }
  static closeAllDialogs() {
    Get.until((route) => !(Get.isDialogOpen==true));
  }
  static close() {
    if (Get.isDialogOpen == true) Get.back(closeOverlays: true);
  }
}
