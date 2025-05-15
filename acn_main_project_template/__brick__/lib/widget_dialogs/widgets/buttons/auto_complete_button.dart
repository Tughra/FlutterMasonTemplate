import 'package:flutter/material.dart';

class AutoCompleteButton extends StatelessWidget {
  const AutoCompleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return SizedBox(
      width: size > 500 ? size * .085 : size * .12,
      height: size > 500 ? size * .085 : size * .12,
      child: Transform.translate(
        offset: const Offset(-4, -1),
        child: IconButton(
          iconSize: 25,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
