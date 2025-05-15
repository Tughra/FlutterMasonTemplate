import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class NotificationActivateWidget extends StatefulWidget {
  final String title;
  final String content;
  final Widget? contentWidget;
  final Widget? icon;
  final Color? titleColor;
  final bool initialValue;
  final bool hasProcess;
  final VoidCallback? onTab;
  final Future<bool> Function() onChanged;

  const NotificationActivateWidget(
      {super.key,
        required this.title,
        this.icon,
        required this.initialValue,
        required this.hasProcess,
        this.contentWidget,
        this.content = "",
        this.titleColor,
        this.onTab,
        required this.onChanged});

  @override
  State<NotificationActivateWidget> createState() => _NotificationActivateWidgetState();
}

class _NotificationActivateWidgetState extends State<NotificationActivateWidget> {
  bool selectedValue = false;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NotificationActivateWidget oldWidget) {
    selectedValue = widget.initialValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTab,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: widget.icon,
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: widget.titleColor ?? Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                if(widget.contentWidget!=null)widget.contentWidget!,
                if (widget.contentWidget==null&&widget.content.isNotEmpty)
                  Text(
                    widget.content,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 13),
                  )
              ],
            ),
          ),
          if (widget.hasProcess)
            SizedBox(
                width: 40,
                height: 40,
                child: CupertinoActivityIndicator(
                  color: context.theme.primaryColor,
                )),
          IgnorePointer(
            ignoring: widget.hasProcess ? true : false,
            child: Switch(
                activeColor: context.theme.primaryColor,
                value: selectedValue,
                onChanged: (_) async {
                  final value = await widget.onChanged.call();
                  setState(() {
                    selectedValue = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
