import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';
import 'package:{{project_file_name}}/core/managers/notifications/notification_permission.dart';
import 'package:{{project_file_name}}/core/managers/observers/life_cycle_observer.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_appbars/appbar.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/notification_activate.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  StreamSubscription<AppLifecycleState>? _cycleSubscription;
  ValueNotifier<bool> systemNotification = ValueNotifier(false);
  Completer<bool> notificationSettingComplete = Completer();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      systemNotificationCall();
    });
    systemNotification.value =
        CheckNotificationPermission.instance.settings.authorizationStatus == AuthorizationStatus.authorized;
    _cycleSubscription = LifeCycleObserver().lifeCycleObserver.listen((value) async {
      switch (value) {
        case AppLifecycleState.resumed:
          systemNotificationCall();
          break;
        default:
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cycleSubscription?.cancel();
    _cycleSubscription = null;
    super.dispose();
  }

  void systemNotificationCall() async {
    systemNotification.value = await Permission.notification.status == PermissionStatus.granted;
    notificationSettingComplete.complete(systemNotification.value);
  }

  @override
  Widget build(BuildContext context) {
    systemNotificationCall();
    final padding = context.padding;
    return Scaffold(
      appBar: const AppBarPrimary(
        hasBack: true,
        title: "Bildirim Ayarları",
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: ValueListenableBuilder<bool>(
                valueListenable: systemNotification,
                builder: (_, state, __) {
                  return NotificationActivateWidget(
                    title: 'Cihaz Bildirimi',
                    content: "Cihazınızın bu uygulamadan bildirim alabilmesi için aktif olmalıdır. Eğer aktif değilse bildirim alamazsınız.",
                    initialValue: state,
                    hasProcess: false,
                    onChanged: () async {
                      notificationSettingComplete = Completer();
                      await AppSettings.openAppSettings(type: AppSettingsType.notification);
                      return await notificationSettingComplete.future;
                    },
                  );
                }),
          ),

          /*
            16.heightIntMargin,
                    Expanded(
            child: ValueListenableBuilder<bool>(
                valueListenable: systemNotification,
                builder: (_, state, __) {
                  return IgnorePointer(ignoring: !state,
                    child: Opacity(opacity: state?1:.5,
                      child: ListView(
                        padding: EdgeInsets.only(left: padding, right: padding),
                        children: [
                          NotificationActivateWidget(
                            title: 'Yeni Teklif ve Poliçe Bildirimleri Bildirimleri ',
                            content:
                                "Müşterilerinizden gelen yeni teklif talepleri ve yaklaşan poliçe yenilemeleri hakkında bildirim alın.",
                            initialValue: false,
                            hasProcess: false,
                            onChanged: () {
                              return Future.value(true);
                            },
                          ),
                          16.heightIntMargin,
                          NotificationActivateWidget(
                            title: 'Yeni Teklif ve Poliçe Bildirimleri',
                            content:
                                "Müşterilerinizden gelen yeni teklif talepleri ve yaklaşan poliçe yenilemeleri hakkında bildirim alın.",
                            initialValue: false,
                            hasProcess: false,
                            onChanged: () {
                              return Future.value(true);
                            },
                          ),
                          16.heightIntMargin,
                          NotificationActivateWidget(
                            title: 'Yeni Teklif ve Poliçe Bildirimleri',
                            content:
                                "Müşterilerinizden gelen yeni teklif talepleri ve yaklaşan poliçe yenilemeleri hakkında bildirim alın.",
                            initialValue: false,
                            hasProcess: false,
                            onChanged: () {
                              return Future.value(true);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
           */
        ],
      ),
    );
  }
}
