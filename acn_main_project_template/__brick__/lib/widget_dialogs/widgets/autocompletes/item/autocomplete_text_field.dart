import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_text_form_field.dart';

class AutocompleteTextField extends StatelessWidget {
  final String title;
  final void Function(String val) onTap;

  const AutocompleteTextField({Key? key,required this.title,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxWidth = maxScreenWidth(context.width * .8);
    final textFieldHeight = maxScreenWidth(maxWidth * .22);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 8,bottom:8),
            child: CustomTextFormField(
              minHeight: textFieldHeight,
              labelText: title,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                suffixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onChanged: (val) => onTap(val),
            ),
          ),
        ),
      ],
    );
  }
}
