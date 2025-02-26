import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/utils/constants/font_manager.dart';

class SendMessageField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController senderController;
  final bool readOnly;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  const SendMessageField(
      {Key? key,
      required this.focusNode,
      required this.senderController,
      required this.readOnly,
      required this.onTap,
       this.onChanged,
      required this.prefixIcon,
      this.suffixIcon,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      readOnly: readOnly,
      controller: senderController,
      onChanged: onChanged,
      onTap: onTap,
      maxLines: 5,
      minLines: 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      style: const TextStyle(fontSize: FontSize.s16),
      decoration: InputDecoration(
        contentPadding:   const EdgeInsets.symmetric(vertical: 16),
        filled: true,
        fillColor: Colors.white,
        isCollapsed: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 0),
          child: prefixIcon,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 0),
          child: suffixIcon,
        ),

        isDense: false,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}
/*
    suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8),
            child: suffixIcon,
          ),
 */