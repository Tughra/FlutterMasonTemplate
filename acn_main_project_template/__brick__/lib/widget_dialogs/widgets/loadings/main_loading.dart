import 'package:flutter/material.dart';

class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 32,height: 32,child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
  }
}
