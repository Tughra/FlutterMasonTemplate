import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'dart:math' as math;
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';


class RefreshCoverageWidget extends StatefulWidget {
  final Widget child;
  final Future Function() refreshCallBack;
  const RefreshCoverageWidget({super.key,required this.child,required this.refreshCallBack});

  @override
  State<RefreshCoverageWidget> createState() => _RefreshCoverageWidgetState();
}

class _RefreshCoverageWidgetState extends State<RefreshCoverageWidget> with SingleTickerProviderStateMixin {
  final ValueNotifier archiveAnimationY = ValueNotifier<double>(-60.0);
  bool shouldRefresh = false;
  late final AnimationController animationController;
  Animation<double>? _animation;
  final duration = const Duration(milliseconds: 300);
  final interval = const Interval(0.0, 1.0);
  Positioned? location;
  late Tween? tween;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: duration,
      vsync: this,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animation = Tween<double>(begin: -60.0, end: -60.0).animate(animationController);
        animationController.reset();
      }
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onVerticalDragUpdate: (detail) {
      if (archiveAnimationY.value < context.height * .112 || detail.delta.dy < 0) {
        archiveAnimationY.value = archiveAnimationY.value + (detail.delta.dy);
      }
    },
      onVerticalDragEnd: (detail) {
        if (archiveAnimationY.value >= context.height * .112) {
          archiveAnimationY.value = -60.0;
          widget.refreshCallBack();
          animationController.stop();
          // PermissionDialogPage.openPermission(PermissionType.location,hasCloseButton: false);
        } else {
          if (!animationController.isAnimating) {
            _animation = Tween<double>(begin: archiveAnimationY.value, end: -60.0).animate(animationController)
              ..addListener(() {
                archiveAnimationY.value = _animation?.value;
              });
            animationController.forward();
          }
        }
      },child: ColoredBox(
        color: Colors.transparent,
        child: Stack(alignment: Alignment.center,children: [
          widget.child,
          ValueListenableBuilder(
              valueListenable: archiveAnimationY,
              builder: (context, value, _) => Positioned(
                  left: 40,
                  top: value,
                  right: 40,
                  child: Transform.rotate(
                    angle: (value * .009) * 2 * math.pi,
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: context.theme.primaryColor),
                        child: const Icon(
                          FontAwesomeIcons.rotateRight,
                          size: ButtonSize.middle,
                          color: Colors.white,
                        )),
                  )))
        ],),
      ),);
  }}