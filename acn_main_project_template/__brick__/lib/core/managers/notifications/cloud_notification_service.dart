import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/model_view/user/user_profile_provider.dart';
import 'package:{{project_file_name}}/models/notification_model.dart';
import 'package:{{project_file_name}}/views/home/notification_page/notification_page.dart';
import 'channel_const.dart';
import 'local_notification_service.dart';

class CloudNotificationService {
  static CloudNotificationService? _cloudNotificationServiceInitialize;
  static FirebaseMessaging? _firebaseMessaging;
  final NotificationService localService = NotificationService.instance;

  static CloudNotificationService get cloudNotificationServiceInitialize {
    if (_cloudNotificationServiceInitialize == null) {
      _firebaseMessaging = FirebaseMessaging.instance;
      return _cloudNotificationServiceInitialize ??= CloudNotificationService();
    } else {
      return _cloudNotificationServiceInitialize!;
    }
  }

  CloudNotificationService() {
    cloudMessagingInitVoid();
  }

  cloudMessagingInitVoid() async {
    _firebaseMessaging?.app.setAutomaticResourceManagementEnabled(true);
    _setupInteractedMessage(); //for terminated state tap notification
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    onMessageListenFirebase();

    ///background on tap interection
  }

  _setupInteractedMessage() {
    // Get any messages which caused the application to open from
    // a terminated state.
    _firebaseMessaging?.getInitialMessage().then((initialMessage) {
      debugPrint("---firebaseMessaging?.getInitialMessage()---");
      if (initialMessage?.messageId != StorageManager.getString("notificationID")) {
        if (initialMessage != null) {
          debugPrint(initialMessage.data.toString());
          _handleMessage(initialMessage);
        }
      }
    });
  }

  void onMessageListenFirebase() {
    debugPrint("?? Firenase Messagin onMessageListen function ??");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("On message Listen from Notification Service");
      //final CustomNotificationModel notificationModel = CustomNotificationModel.fromJson(message.data);
      //final String? iosCategoryID = message.category;
      //final String? iosThreadID = message.threadId;
      //final String? androidChannelID = message.notification?.android?.channelId;
      //RemoteNotification? notification = message.notification;
      //AndroidNotification? android = message.notification?.android;
      //notificationModel.channelId! gelen bildirimleri channel id'lerine göre gösterilebilir
      //debugPrint(notificationModel.toJson().toString());
      if (message.notification != null && (message.notification!.title ?? "").isNotEmpty) {
        if ((message.notification?.android?.imageUrl ?? "").isNotEmpty || (message.notification?.apple?.imageUrl ?? "").isNotEmpty) {
          if (Platform.isIOS) {
            localService.showBigPictureNotificationIos(
                notificationID: message.notification.hashCode,
                title: message.notification!.title!,
                body: message.notification!.body ?? "",
                imageUrl: message.notification?.apple?.imageUrl,
                customNotificationModel: CustomNotificationModel(channelId: message.data["channel-id"],
                    notificationID: message.notification.hashCode,
                    title: message.notification!.title!,
                    body: message.notification!.body ?? "",
                    image: message.notification?.apple?.imageUrl,
                    icon: message.data["icon"],
                    hexColor: message.data["hex-color"]));
          } else {
            localService.showBigPictureNotification(
                notificationID: message.notification.hashCode,
                title: message.notification!.title!,
                body: message.notification!.body ?? "",
                imageUrl: message.notification?.android?.imageUrl,
                customNotificationModel: CustomNotificationModel(channelId:message.data["channel-id"] ,
                    notificationID: message.notification.hashCode,
                    title: message.notification!.title!,
                    body: message.notification!.body ?? "",
                    image: message.notification?.android?.imageUrl,
                    icon: message.data["icon"],
                    hexColor: message.data["hex-color"]));
          }
        } else {
          localService.showBigTextNotification(
              notificationID: message.notification.hashCode,
              title: message.notification!.title!,
              body: message.notification!.body ?? "",
              customNotificationModel: CustomNotificationModel(channelId: message.data["channel-id"],
                  notificationID: message.notification.hashCode,
                  title: message.notification!.title!,
                  body: message.notification!.body ?? "",
                  image: null,
                  icon: message.data["icon"],
                  hexColor: message.data["hex-color"]));
        }
      }

    });
  }

  _handleMessage(RemoteMessage? message) async {
    if (message != null) {
      StorageManager.setString("notificationID", message.messageId!);
      if (message.data["channel-id"] == NotificationChannelID.general.channelID) {
        final value = await GetIt.instance<UserProfileProvider>().authCompleter.future;
        if (value) {
          Get.to(
            () => const NotificationsPage(),
            routeName: "/NotificationsPage",
          );
        }
      }
    }
  }
}
