import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/buttons/sml_back_button.dart';

abstract class AcnHeader extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final bool canPop;
  final bool shouldPop;
  final VoidCallback? whenPop;
  final bool onlyTitle;
  final MainAxisAlignment alignment;

  const AcnHeader(
      {Key? key,
      this.title,
      this.icon,
      this.canPop = false,
      this.shouldPop = true,
      this.whenPop,
      this.onlyTitle = false,
      this.alignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraintHeight = maxScreenWidth(MediaQuery.sizeOf(context).width) / 3;
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (!onlyTitle) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10, left: (context.width - context.width * .8) / 2),
                child: const AcnHeaderImageWidget(),
              ),
            ],
            title == null
                ? const SizedBox.shrink()
                : Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.only(left: alignment == MainAxisAlignment.center ? 0 : (context.width - context.width * .8) / 2, top: 10, bottom: 10),
                          color: Theme.of(context).primaryColor,
                          alignment: Alignment.centerLeft,
                          width: context.width,
                          child: Row(
                            mainAxisAlignment: alignment,
                            children: [
                              if (icon != null) ...[
                                icon!,
                                20.widthIntMargin,
                              ],
                              Text(
                                title!,
                                style: TextStyle(color: Colors.white, fontSize: (constraintHeight * .14)>20?20:(constraintHeight * .14)),
                              ),
                            ],
                          )),
                      if (canPop)
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: CustomBackButton(
                            whenPop: whenPop,
                            shouldPop: shouldPop,
                            size: ButtonSize.standard,
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class AcnHeaderWidget extends AcnHeader {
  const AcnHeaderWidget.withTitle({super.key, required super.title, super.canPop, super.icon, super.alignment});

  const AcnHeaderWidget.onlyTitle({super.key, required super.title, super.canPop, super.icon, super.whenPop, super.alignment})
      : super(onlyTitle: true, shouldPop: false);

  const AcnHeaderWidget.simple({super.key});
}

class AcnHeaderImageWidget extends StatelessWidget {
  const AcnHeaderImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Image.asset(
        LogosAssets.appLogo,
        fit: BoxFit.contain,
        color: Theme.of(context).primaryColor,
        width: context.width / 2.5,
        height: context.width / 10,
      ),
    );
  }
}
