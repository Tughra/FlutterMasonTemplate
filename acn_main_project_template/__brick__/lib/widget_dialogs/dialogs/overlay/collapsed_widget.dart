import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/widget_dialogs/dialogs/overlay/top_overlay/collapsed_overlay.dart';




class CollapsedWidget extends StatefulWidget {
  final Widget? child;

  const CollapsedWidget({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  State<CollapsedWidget> createState() => _CollapsedWidgetState();
}

class _CollapsedWidgetState extends State<CollapsedWidget> {
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => CollapsedOverlay.instance.widget ?? Container(),
    );
    CollapsedOverlay.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}