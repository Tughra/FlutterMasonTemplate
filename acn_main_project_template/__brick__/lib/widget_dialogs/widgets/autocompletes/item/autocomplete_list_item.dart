import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';

class AutocompleteListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData? icon;
  final IconPosition alignment;

  const AutocompleteListItem(
      {Key? key,
        required this.title,
        required this.onTap,
        this.icon,
        this.alignment = IconPosition.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSize = maxScreenWidth(MediaQuery.sizeOf(context).width)*.11;//MediaQuery.of(context).size.height * 0.05;
    return Column(
      children: [
        SizedBox(
          height:itemSize,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  if (alignment == IconPosition.left && icon!=null)
                    Center(
                        child: Icon(icon ,
                            color: Theme.of(context).primaryColor)),
                  12.widthIntMargin,
                  Expanded(
                    child: RichText(
                      text:TextSpan(text: title==""?"Empty":title,style: TextStyle(color: Theme.of(context).colorScheme.onSurface,fontSize:itemSize*.3,fontWeight: FontWeight.w500), ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(thickness: 1,height: 16.0,color: Theme.of(context).colorScheme.onSurface.withOpacity(.2),)
      ],

    );

  }
}
enum IconPosition{
  left,
  right
}