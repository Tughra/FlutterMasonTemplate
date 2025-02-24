import 'package:flutter/material.dart';
import 'package:provider/provider.dart';





class InjectParentProvider extends StatelessWidget {
  final List<ChangeNotifierProvider> providers;
  final Widget page;
  const InjectParentProvider({super.key,required this.providers,required this.page});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: providers,child: page,);
  }
}



void navigatePop(
  BuildContext context,
) {
  Navigator.of(context).pop();
}

void navigateAndRemove(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    routeName,
    arguments: arguments,
    (route) => false,
  );
}

Future<Object?> navigateTo(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  return Navigator.of(context).pushNamed(
    routeName,
    arguments: arguments,
  );
}

void navigateAndReplace(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  Navigator.of(context).pushReplacementNamed(
    routeName,
    arguments: arguments,
  );
}
