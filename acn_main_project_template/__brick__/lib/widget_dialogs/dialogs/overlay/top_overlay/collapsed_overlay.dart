
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/widget_dialogs/dialogs/overlay/collapsed_widget.dart';


class OverlayController {
 // final OverlayPortalController _tooltipController = OverlayPortalController();

 // OverlayPortalController get tooltipController => _tooltipController;

  static final OverlayController _instance = OverlayController._init();

  OverlayController._init();

  factory OverlayController() {
    return _instance;
  }

  OverlayEntry? overlayEntry;

  void showOverlay(BuildContext context, {required Widget child}) {
    if (overlayEntry == null) {
      isShowing = true;
      overlayEntry = OverlayEntry(builder: (_){
        return child;
      });
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  bool isShowing = false;

  bool willPop({bool canPop = true}) {
    if (isShowing) {
      closeOverlay();
      return false;
    } else {
      return canPop;
    }
  }

  void closeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    isShowing = false;
  }
  Future<T> showOverlayAsync<T>(BuildContext context, {required Widget child,required Future<T> Function() asyncFunction})async{
    if (overlayEntry == null) {
      isShowing = true;
      overlayEntry = OverlayEntry(builder: (_){
        return child;
      });
      Overlay.of(context).insert(overlayEntry!);
    }
    T data;
    try {
      data = await asyncFunction();
    } on Exception catch (_) {
      closeOverlay();
      rethrow;
    }
    closeOverlay();
    return data;
  }
}

enum CollapsedOverlayStatus {
  show,
  dismiss,
}

typedef CollapsedOverlayStatusCallback = void Function(CollapsedOverlayStatus status);


class CollapsedOverlay{
  Widget? _widget;
  OverlayEntry? overlayEntry;
  Timer? _timer;
  final List<CollapsedOverlayStatusCallback> _statusCallbacks =
  <CollapsedOverlayStatusCallback>[];
  //GlobalKey<EasyLoadingContainerState>? _key;
  //GlobalKey<EasyLoadingProgressState>? _progressKey;
  //GlobalKey<EasyLoadingContainerState>? get key => _key;
  //GlobalKey<EasyLoadingProgressState>? get progressKey => _progressKey;
  factory CollapsedOverlay() => _instance;
  static final CollapsedOverlay _instance = CollapsedOverlay._internal();

  CollapsedOverlay._internal();

  Widget? get widget => _widget;

  static CollapsedOverlay get instance => _instance;
  static bool get isShow => _instance._widget != null;

  /// init CollapsedOverlay
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, CollapsedWidget(child: child));
      } else {
        return CollapsedWidget(child: child);
      }
    };
  }
//  Future<void> _dismiss(bool animation) async {
//    if (key != null && key?.currentState == null) {
//      _reset();
//      return;
//    }
//
//    return key?.currentState?.dismiss(animation).whenComplete(() {
//      _reset();
//    });
//  }
//
//  void _reset() {
//    _widget = null;
//    _key = null;
//    _progressKey = null;
//    _cancelTimer();
//    _markNeedsBuild();
//    _callback(CollapsedOverlayStatus.dismiss);
//  }
//
//  void _callback(CollapsedOverlayStatus status) {
//    for (final EasyLoadingStatusCallback callback in _statusCallbacks) {
//      callback(status);
//    }
//  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

}