import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:{{project_file_name}}/utils/constants/font_manager.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final double? height;
  final String? labelText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? helperText;
  final String? errorText;
  final String? counterText;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? enabled;
  final bool? filled;
  final bool? readOnly;
  final bool? autoFocus;
  final List<TextInputFormatter>? inputFormatters;

  const RoundedTextField(
      {super.key,
      this.controller,
      this.onChanged,
      this.onTap,
      this.enabled,
      this.height,
      this.labelText,
      this.hintText,
      this.hintTextStyle,
      this.helperText,
      this.errorText,
      this.maxLines,
      this.counterText,
        this.filled,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly,
      this.autoFocus,
      this.inputFormatters,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    Color color = context.theme.colorScheme.surface;
    return SizedBox(
      width: double.infinity,
      child: TextField(
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        autofocus: autoFocus ?? false,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        enabled: enabled,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          filled:filled ,
          fillColor: Colors.white,
          alignLabelWithHint: true,
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
          counterText: counterText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle:hintTextStyle,
          prefixIconConstraints: BoxConstraints.tight(const Size(32, 32)),
          contentPadding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow,width: 1)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
              borderRadius: BorderRadius.circular(8)),
        ),
        maxLines: maxLines ?? 1,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: FontSize.s16),
      ),
    );
  }
}
