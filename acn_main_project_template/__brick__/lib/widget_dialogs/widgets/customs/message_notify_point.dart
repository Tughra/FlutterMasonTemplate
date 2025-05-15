import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/core/managers/url_launcher_manager.dart';
import 'package:{{project_file_name}}/model_view/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageNotify extends StatelessWidget {
  final int messageCount;
  final double size;
  final bool hasNumber;

  const MessageNotify({Key? key, required this.messageCount, this.size = 12, this.hasNumber = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (messageCount > 0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            shape: BoxShape.circle,
            color: context.theme.primaryColor),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.fromSize(
              size: Size(size, size),
              child: hasNumber
                  ? Center(
                      child: Text(
                        messageCount > 100 ? "+99" : (messageCount).toString(),
                        textAlign: TextAlign.center,
                        textScaleFactor: 0.9,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: size - 5),
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final String content;
  final String date;
  final bool readState;

  const NotificationContainer({Key? key, required this.content, required this.date, required this.readState}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100),
        child: DecoratedBox(
          decoration:
               BoxDecoration(color:Theme.of(context).colorScheme.surface),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.heightIntMargin,
              Row(
                children: [
                  8.widthIntMargin,
                  if (!readState) ...[
                    DecoratedBox(
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                      child: const SizedBox(
                        width: 12,
                        height: 12,
                      ),
                    ),
                    10.widthIntMargin,
                  ],
                  Text(
                    date,
                    style: TextStyle(fontSize: 12, color:context.read<AppThemeProvider>().currentIsDark?Colors.white:Theme.of(context).primaryColor),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Linkify(
                  onOpen: (link) async {
                    UrlLauncher.launchLink(link: link.url,launchMode: LaunchMode.inAppBrowserView);
                  },
                  text: content,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface,fontSize: 14),
                  linkStyle: const TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ));
  }
}
