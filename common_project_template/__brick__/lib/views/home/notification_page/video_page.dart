import 'dart:io';

import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoUrl;

  const VideoPage({super.key, required this.videoUrl});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late final WebViewController webViewController;
  final ValueNotifier<int> progressNotifier = ValueNotifier(0);

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            progressNotifier.value = (progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            debugShow(error);
          },
          onNavigationRequest: (NavigationRequest request) {
            if(Platform.isIOS) return NavigationDecision.navigate;
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.videoUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ValueListenableBuilder<int>(
          valueListenable: progressNotifier,
          builder: (ctx, progress, __) {
            return progress != 100
                ? ColoredBox(
                    color: Colors.black,
                    child: CircularPercentIndicator(
                      radius: 60.0,
                      animation: false,
                      lineWidth: 8.0,
                      percent: progress / 100,
                      center: Text(
                        "%$progress",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Theme.of(ctx).colorScheme.onSecondary,
                      progressColor: Theme.of(ctx).primaryColor,
                    ),
                  )
                : WebViewWidget(
                    controller: webViewController,
                  );
          }),
    );
  }
}
