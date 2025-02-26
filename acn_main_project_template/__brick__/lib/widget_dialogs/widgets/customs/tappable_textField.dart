import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_text_form_field.dart';

class TappableTextField extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String? Function(String?)? validator;
  const TappableTextField({Key? key,required this.title,required this.onTap,this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      minHeight: 54,
      onTap: onTap,
      validator: validator,
      labelText: title,
      filled: true,
      enabled: false,
      suffixIcon: RotatedBox(quarterTurns: 1, child: Icon(FontAwesomeIcons.play, color: Theme.of(context).primaryColor)),
    );
  }
}
