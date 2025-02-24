import 'package:flutter/material.dart';

class EmptyListPage extends StatelessWidget {
  final String? customContent;
  const EmptyListPage({super.key,this.customContent});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        customContent??"Sonuç Yok",textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
