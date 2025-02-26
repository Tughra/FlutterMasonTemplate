import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/core/functions/global_functions.dart';

class StepAppBar extends _StepAppBar {
  const StepAppBar.fromPageController(
      {super.key,
      required super.title,
      super.hasBack,
      required super.pageController});
  const StepAppBar.fromRoute(
      {super.key,
      required super.title,
      super.hasBack,
      required super.navigateBack});
}

abstract class _StepAppBar extends StatelessWidget {
  final PageController? pageController;
  final bool hasBack;
  final String title;
  final bool navigateBack;

  const _StepAppBar(
      {Key? key,
      required this.title,
      this.pageController,
      this.hasBack = true,
      this.navigateBack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: hasBack
              ? IconButton(
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (navigateBack) {
                      closeKeyboard(context);
                      Get.back();
                    } else {
                      closeKeyboard(context);
                      pageController?.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    }
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.colorScheme.secondary,
                    ),
                    child: const Center(
                      child:Icon(Icons.arrow_circle_left_outlined),
                    ),
                  ))
              : const SizedBox.shrink(),
        ),
        Flexible(
          child: FittedBox(
            child: SizedBox(
              width: context.mediaQuerySize.width - 60,
              child: Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        30.widthIntMargin,
      ],
    );
  }

  closeKeyboard(BuildContext context) {
    if (isKeyboardOpen()) FocusScope.of(context).unfocus();
  }
}
