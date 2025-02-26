import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';

enum BorderType { flat, rounded, empty }

enum Type { outlined, underlined }

class CustomTextFormField extends StatelessWidget {
  final bool? readOnly;
  final bool? isDense;
  final bool? filled;
  final double minHeight;
  final Function()? onTap;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String val)? onChanged;
  final TextCapitalization? textCapitalization;
  final InputDecoration? decoration;
  final BorderType? borderType;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final int? maxLines;
  final int? minLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;
  final String? initialValue;
  final bool enablePaste;
  final Type? type;
  final void Function(String val)? onFieldSubmitted;
  final Color? curserColor;
  final TextStyle? style, hintStyle, labelStyle, errorStyle;
  final double? marginTop;
  final double? marginBottom;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({super.key,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.filled,
    required this.minHeight,
    this.enablePaste = true,
    this.isDense = true,
    this.labelText,
    this.type = Type.outlined,
    this.hintText,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.validator,
    this.autofillHints,
    this.inputFormatters,
    this.onChanged,
    this.textCapitalization,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.minLines,
    this.initialValue,
    this.maxLines = 1,
    this.decoration,
    this.contentPadding,
    this.maxLength,
    this.obscureText,
    this.textInputType,
    this.textInputAction,
    this.enabled = true,
    this.autoValidateMode,
    this.borderType = BorderType.rounded,
    this.onTap,
    this.style,
    this.curserColor,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.focusedBorderColor,
    this.enabledBorderColor});

  BorderRadius get _borderRadius =>borderType == BorderType.flat ? BorderRadius.circular(0) : BorderRadius.circular(minHeight*.2);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return TextFormField(
      enableInteractiveSelection: enablePaste,
      // will disable paste operation
      autofillHints: autofillHints,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      style: style ?? TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _maxTextFieldHeight(minHeight,deviceWidth: width) * .38),
      onTap: onTap,
      expands: false,
      autocorrect: false,
      readOnly: readOnly ?? false,
      autovalidateMode: autoValidateMode,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      cursorColor: curserColor ?? Theme
          .of(context)
          .primaryColor,
      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      initialValue: initialValue,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(

        suffixIconConstraints: BoxConstraints(maxHeight: _maxTextFieldHeight(minHeight,deviceWidth: width)),
        isDense: isDense,
        labelStyle: labelStyle ?? TextStyle(fontSize: _maxTextFieldHeight(minHeight,deviceWidth: width) * .38),
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: _maxTextFieldHeight(minHeight,deviceWidth: width) * .38,color: Theme.of(context).colorScheme.secondary
            ),
        errorStyle: errorStyle ?? TextStyle(height: 0.3, fontSize: _maxTextFieldHeight(minHeight,deviceWidth: width) * .3,fontWeight: FontWeight.w500),
        alignLabelWithHint: false,
        floatingLabelBehavior: decoration != null && decoration?.floatingLabelBehavior != null ? decoration?.floatingLabelBehavior : null,
        fillColor: decoration != null && decoration?.fillColor != null ? decoration?.fillColor : null,
        filled: decoration != null && decoration?.filled != null ? decoration?.filled : filled,
        hintText: hintText ?? '',
        prefix: decoration != null && decoration?.prefix != null ? decoration?.prefix : prefix,
        prefixIcon: decoration != null && decoration?.prefixIcon != null ? decoration?.prefixIcon : prefixIcon,
        suffix: decoration != null && decoration?.suffix != null ? decoration?.suffix : suffix,
        suffixIcon: decoration != null && decoration?.suffixIcon != null ? decoration?.suffixIcon : suffixIcon,
        contentPadding: contentPadding ?? (decoration != null && decoration?.contentPadding != null
            ? decoration?.contentPadding
            : type == Type.underlined
            ? const EdgeInsets.only(bottom: 8, top: 8)
            : EdgeInsets.only(left: 10, top: _maxTextFieldHeight(minHeight,deviceWidth: width) * .4, bottom: _maxTextFieldHeight(minHeight,deviceWidth: width) * .4, right: 10)),
        labelText: labelText,
        focusedBorder: decoration != null && decoration?.focusedBorder != null
            ? decoration?.focusedBorder
            : type != Type.outlined
            ? UnderlineInputBorder(borderSide: borderType == BorderType.empty ? BorderSide.none : BorderSide(color: context.theme.primaryColor, width: 1))
            : OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: focusedBorderColor ?? Theme.of(context).secondaryHeaderColor),
          borderRadius: _borderRadius,
        ),
        enabledBorder: decoration != null && decoration?.enabledBorder != null
            ? decoration?.enabledBorder
            : type != Type.outlined
            ? UnderlineInputBorder(borderSide: borderType == BorderType.empty ? BorderSide.none : const BorderSide(color: Colors.red, width: 1))
            : OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: enabledBorderColor ?? context.theme.colorScheme.onSurface.withValues(alpha: .3)),
          borderRadius: _borderRadius,
        ),
        errorBorder: decoration != null && decoration?.errorBorder != null
            ? decoration?.errorBorder
            : type != Type.outlined
            ? null
            : OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: _borderRadius,
        ),
        focusedErrorBorder: decoration != null && decoration?.focusedErrorBorder != null
            ? decoration?.focusedErrorBorder
            : type != Type.outlined
            ? null
            : OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: _borderRadius,
        ),
        disabledBorder: decoration != null && decoration?.disabledBorder != null
            ? decoration?.disabledBorder
            : type != Type.outlined
            ? null
            : OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black26),
          borderRadius: _borderRadius,
        ),
        enabled: decoration != null && decoration?.enabled != null ? decoration!.enabled : true,
        counterText: "",
      ),
    );
  }
}

double _maxTextFieldHeight(double height, {required double deviceWidth}) {
  final bool isTabletWidth = deviceWidth.isTabletWidth;
  if (isTabletWidth) return height > 54 ? 54 : height;
  return height > 40 ? 40 : height;
}