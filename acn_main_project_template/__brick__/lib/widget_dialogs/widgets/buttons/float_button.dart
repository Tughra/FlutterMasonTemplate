import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';

class ExpandedFabIcon extends StatelessWidget {
  final String heroTag;
  final String title;
  final VoidCallback onPressed;
  final IconData icon;
  const ExpandedFabIcon({Key? key,required this.heroTag,required this.title,required this.onPressed,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
            mini: true,
            tooltip: title,
            heroTag: heroTag,
            backgroundColor: Colors.white,
            onPressed: onPressed,
            child: CircleAvatar(
              maxRadius: 24,
              minRadius: 22,
              backgroundColor: Colors.white,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  )),
            )),
        4.heightIntMargin,
        Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
      ],
    );
  }
}
