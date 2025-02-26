import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomBanner extends StatelessWidget {
  final String content;
  final bool isSuccess;
  final VoidCallback? secondButton;
  final String? secondButtonText;
  final AlignmentGeometry alignment;
  const CustomBanner(this.content,
      {Key? key,
      this.isSuccess = false,
      this.secondButton,
      this.secondButtonText,
      this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: alignment,
          child: MaterialBanner(
            forceActionsBelow: false,
            /*onVisible:()async{
                 await Future.delayed(Duration(seconds:5),(){
                    print("dadadadadadada");
                   // ScaffoldMessenger.of(Get.context).hideCurrentMaterialBanner();
                  });
                },

                 */
            overflowAlignment: OverflowBarAlignment.center,
            content: Text(content,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                isSuccess
                    ? const Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.info,
                        color: Colors.white,
                      )
              ],
            ),
            backgroundColor: const Color.fromRGBO(214, 0, 13, 1),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(Get.context!)
                            .hideCurrentMaterialBanner();
                        Get.back();
                      },
                      child: const Text(
                        'Tamam',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                  secondButtonText != null
                      ? Visibility(
                          visible: secondButtonText!.isNotEmpty,
                          child: TextButton(
                              onPressed: secondButton,
                              child: Text(
                                secondButtonText!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )))
                      : const SizedBox.shrink()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
