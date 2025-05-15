import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class NotificationActivateWidget extends StatefulWidget {
  final String title;
  final bool initialValue;
  final bool hasProccess;
  final bool isLastIndex;
  final Future<bool> Function() onChanged;
  const NotificationActivateWidget(
      {Key? key,
      required this.title,
      required this.initialValue,
        required this.hasProccess,
      this.isLastIndex = false,
      required this.onChanged})
      : super(key: key);

  @override
  State<NotificationActivateWidget> createState() =>
      _NotificationActivateWidgetState();
}

class _NotificationActivateWidgetState
    extends State<NotificationActivateWidget> {
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
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Color.fromRGBO(78, 77, 115, 1)),
            ),
            const Spacer(),
            if(widget.hasProccess)SizedBox(width: 40,height: 40,child: CupertinoActivityIndicator(color: context.theme.primaryColor,)),
            IgnorePointer(ignoring: widget.hasProccess?true:false,
              child: Switch(
                  activeColor: context.theme.primaryColor,
                  value: selectedValue,
                  onChanged:(_) async{
                    final value = await widget.onChanged.call();
                    setState(() {
                      selectedValue = value;
                    });
                  }),
            ),

          ],
        ),
        if (widget.isLastIndex) const Divider(),
      ],
    );
  }
}
