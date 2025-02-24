import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/widgets_dialogs/dialogs/banners/custom_banner.dart';

abstract class DialogServiceInterface {
  void showCustomDialog(String message,
      {bool isSuccess = false,
      VoidCallback? secondButton,
      String? secondButtonText,
      bool dismissible = true,
      AlignmentGeometry alignment = Alignment.topCenter});

  void showCustomSnack(String message,
      {bool isSuccess = false,
      bool allowErrorColor = false,
        SnackStyle snackStyle=SnackStyle.FLOATING,
      SnackPosition snackPosition = SnackPosition.BOTTOM});
}

class DialogService implements DialogServiceInterface {
  static final DialogService _dialogService = DialogService._init();

  static DialogService get instance => _dialogService;

  DialogService._init();

  @override
  showCustomDialog(String content,
      {bool isSuccess = false,
      VoidCallback? secondButton,
      String? secondButtonText,
      bool dismissible = true,
      AlignmentGeometry alignment = Alignment.topCenter}) {
    if (Get.routing.route?.settings.name == "/LoadingDialog") Get.back();
    Get.dialog(
        CustomBanner(
          content,
          isSuccess: isSuccess,
          secondButton: secondButton,
          secondButtonText: secondButtonText,
          alignment: alignment,
        ),
        routeSettings: const RouteSettings(name: "/CustomBanner"),
        barrierColor: Colors.transparent,
        barrierDismissible: dismissible);
  }

  @override
  void showCustomSnack(String content,
      {bool isSuccess = false,
      bool allowErrorColor = false,
        Duration? duration,
        SnackStyle snackStyle=SnackStyle.FLOATING,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    if (Get.routing.route?.settings.name == "/LoadingDialog") Get.back();
        Get.rawSnackbar(duration: duration??const Duration(seconds: 3),
      messageText: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),
      ),
      backgroundColor:isSuccess?AppColor.greenColor:allowErrorColor?AppColor.errorColor:Colors.grey.shade800,
      snackPosition: snackPosition,
      snackStyle: snackStyle
    );
  }

}
