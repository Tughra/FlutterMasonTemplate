import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';

class AppBarPrimary extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool? hasBack;
  final Size? appBarSize;
  final PreferredSizeWidget? tabBar;
  final Widget? leading;
  final double? toolbarHeight;
  final Color? color;
  final Color? titleTextColor;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  const AppBarPrimary(
      {Key? key,
      this.title,
      this.titleWidget,
      this.actions,
      this.hasBack,
      this.appBarSize,
      this.tabBar,
      this.leading,
      this.systemUiOverlayStyle,
      this.color,
      this.titleTextColor,
      this.toolbarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontSize = ((maxScreenWidth(context.width)*.05).clamp(14, 24)).toDouble();
    return AppBar(
      toolbarHeight: toolbarHeight ?? 54,
      surfaceTintColor: Colors.transparent,
      actions: actions,
      centerTitle: true,

      title:titleWidget??Text(
        title ?? "",
        style: TextStyle(
            fontSize: fontSize,
            fontStyle: FontStyle.normal,
            color: titleTextColor??Theme.of(context).secondaryHeaderColor),
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.w500),
      backgroundColor: color ??Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: hasBack ?? false,
      iconTheme:IconThemeData(color: Theme.of(context).secondaryHeaderColor) ,
      actionsIconTheme:
          IconThemeData(color: Theme.of(context).secondaryHeaderColor),
      elevation: 0,

      bottom: tabBar,
      leading: leading,
      systemOverlayStyle: systemUiOverlayStyle??SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light,statusBarColor:color ??Theme.of(context).scaffoldBackgroundColor ),
    );
  }

  @override
  Size get preferredSize => appBarSize ?? const Size(0, 54);
}
