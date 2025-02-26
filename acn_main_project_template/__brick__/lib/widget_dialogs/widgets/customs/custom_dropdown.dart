import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'custom_text_form_field.dart';

class CustomDropdown<T extends Object> extends StatelessWidget {
  final T? value;
  final AutovalidateMode autoValidateMode;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? hint;
  final String? labelText;
  final Color? borderColor;
  final String? Function(T?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final BorderType borderType;
  final bool enabledBorder;
  final bool isEnabled;
  final bool filled;
  final double? itemHeight;
  final double minHeight;
  final TextStyle? style, hintStyle, labelStyle, errorStyle;

  const CustomDropdown({
    Key? key,
    required this.minHeight,
    this.enabledBorder = true,
    this.filled = true,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.itemHeight,
    this.value,
    this.isEnabled = true,
    this.items,
    this.onChanged,
    this.hint,
    this.labelText,
    this.borderColor,
    this.validator,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.borderType = BorderType.rounded,
  }) : super(key: key);
  BorderRadius get _borderRadius =>borderType == BorderType.flat ? BorderRadius.circular(0) : BorderRadius.circular(minHeight*.2);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(dropdownColor: Theme.of(context).colorScheme.surface,
        isDense: true,
        elevation: 8,
        autovalidateMode: autoValidateMode,
        style: style ?? TextStyle(color: Theme.of(context).colorScheme.onSurface,fontSize: _maxTextFieldHeight(minHeight,deviceWidth: width)* .38),
        decoration: InputDecoration(
          isCollapsed: false,
          alignLabelWithHint: false,
          prefixIconConstraints: BoxConstraints.tight(Size(minHeight * .5, minHeight * .5)),
          suffixIconConstraints: BoxConstraints.tight(Size(minHeight * .5, minHeight * .5)),
          filled: filled,
          fillColor: isEnabled?Colors.white:Colors.grey[200],
          labelStyle: labelStyle ?? TextStyle(color: isEnabled?Theme.of(context).colorScheme.onSurface:Colors.grey[500],fontSize: _maxTextFieldHeight(minHeight,deviceWidth: width)* .38),
          hintStyle: hintStyle ??
              TextStyle(
                fontSize: minHeight * .2,
              ),
          errorStyle: errorStyle ?? TextStyle(height: 0.3, fontSize: minHeight * .15),
          labelText: labelText ?? "",
          enabled: isEnabled,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .3)),
            borderRadius: _borderRadius,
          ),
          disabledBorder:OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .1)),
        borderRadius: _borderRadius,
      ),
          //color: enabledBorderColor ?? context.theme.colorScheme.surface
          focusedBorder: OutlineInputBorder(
            borderSide: isEnabled == true ? const BorderSide(width: 1, color: Colors.black54, style: BorderStyle.solid) : BorderSide.none,
            borderRadius: _borderRadius,
          ),
          contentPadding: contentPadding ?? EdgeInsets.only(left: 10, top: _maxTextFieldHeight(minHeight,deviceWidth: width) * .4, bottom: _maxTextFieldHeight(minHeight,deviceWidth: width) * .4, right: 10),
          border: OutlineInputBorder(
            borderSide: isEnabled == true ? const BorderSide(width: 1, color: Colors.black54, style: BorderStyle.none) : BorderSide.none,
            borderRadius: _borderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: isEnabled == true ? const BorderSide(width: 2, color: Colors.red) : BorderSide.none,
            borderRadius: _borderRadius,
          ),
        ),
        validator: validator,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
        value: value,
        hint: hint != null
            ? Text(
                '$hint',
              )
            : null,
      ),
    );
  }
}
double _maxTextFieldHeight(double height, {required double deviceWidth}) {
  final bool isTabletWidth = deviceWidth.isTabletWidth;
  if (isTabletWidth) return height > 54 ? 54 : height;
  return height > 40 ? 40 : height;
}
