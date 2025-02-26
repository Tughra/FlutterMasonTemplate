import 'dart:convert';
import 'dart:io';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/model_view/user/user_profile_provider.dart';
import 'package:{{project_file_name}}/models/notification_model.dart';
import 'package:{{project_file_name}}/utils/constants/app_consts.dart';
import 'package:{{project_file_name}}/views/home/notification_page/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'channel_const.dart';
import 'notification_show/channel_details.dart';

@pragma('vm:entry-point')
void didReceiveNotificationBackground(NotificationResponse notificationResponse) {
  debugPrint("------------didReceiveNotificationBackground----------------");
  switch (notificationResponse.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      {
        debugPrint("------------Tapped BODY Background----------------");
        //onNotifications.add(notificationResponse.payload);
      }
      break;
    case NotificationResponseType.selectedNotificationAction:
      {
        debugPrint("------------Action Tapped Background----------------");
        //onNotifications.add(notificationResponse.actionId);
      }
      break;
  }
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  static NotificationService get instance => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late final InitializationSettings initializationSettings;

  NotificationService._internal() {
    //notifyPermissions();
    init();
    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      // when terminate state notification tapped
      if (value != null &&
          value.didNotificationLaunchApp == true &&
          value.notificationResponse?.payload != null &&
          value.notificationResponse!.payload!.isNotEmpty) {
        debugPrint(value.notificationResponse?.payload.toString());
        final CustomNotificationModel notificationModel =
            CustomNotificationModel.fromJson(jsonDecode(value.notificationResponse!.payload!));
        final clickedID = StorageManager.getString(
            AppConstant.clickedNotificationID); // notification ıd'yi notificationResponse idsinden alabilirsin
        debugPrint("convertedUID:${notificationModel.notificationID.toString()}");
        debugPrint("clickedID:$clickedID");
        if (clickedID != notificationModel.notificationID.toString()) {
          _onClickedNotification(notificationModel: notificationModel);
        }
      }
    });
  }

  Future<void> _createAndroidGroup() async {
    // create the group first
    AndroidNotificationChannelGroup commonGroupAndroid = AndroidNotificationChannelGroup(
        NotificationGroupID.commonCategory.categoryID, NotificationGroupID.commonCategory.categoryName,
        description: 'Poliçeler, kampanyalar ve analizler');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannelGroup(commonGroupAndroid);
    // create channels associated with the group
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(AndroidNotificationChannel(
            NotificationChannelID.general.channelID, NotificationChannelID.general.channelName,
            description: '',
            groupId: NotificationGroupID.commonCategory.categoryID,
            showBadge: true,
            importance: Importance.max));
  }

  Future<void> init() async {
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestCriticalPermission: true,
      defaultPresentAlert: true,
      defaultPresentSound: true,
      defaultPresentBadge: false,
      //notificationCategories: darwinNotificationCategories,
    );
    //IOSFlutterLocalNotificationsPlugin().requestPermissions();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
       //print("=====onDidReceiveNotificationResponse===== >${response.payload!}");
      final CustomNotificationModel notificationModel = CustomNotificationModel.fromJson(jsonDecode(response.payload??""));
      _onClickedNotification(notificationModel: notificationModel);
    }, onDidReceiveBackgroundNotificationResponse: didReceiveNotificationBackground);
    if (Platform.isAndroid) {
      await _createAndroidGroup();
    }
    //flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  void _onClickedNotification({required CustomNotificationModel notificationModel}) async {
    StorageManager.setString(AppConstant.clickedNotificationID, notificationModel.notificationID.toString());
    if (notificationModel.channelId == NotificationChannelID.general.channelID) {
      final value = await GetIt.instance<UserProfileProvider>().authCompleter.future;
      debugPrint("=======Completer Done======== $value");
      //yönlenmeleri messageType'a göre yaparsın ileride
      if (value) {
        Get.to(
          () => const NotificationsPage(),
          routeName: "/NotificationsPage",
        );
      }
    }
  }

  Future<void> showBigTextNotification(
      {required int notificationID,
      required String title,
      required String body,
      required CustomNotificationModel customNotificationModel}) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '<i>$body</i>',
      htmlFormatSummaryText: true,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        NotificationChannelID.general.channelID, NotificationChannelID.general.channelName,
        importance: Importance.max,
        priority: Priority.max,
        setAsGroupSummary: false,
        styleInformation: bigTextStyleInformation);
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      threadIdentifier: NotificationChannelID.general.channelID,
      subtitle: NotificationChannelID.general.channelName,
      categoryIdentifier: NotificationGroupID.commonCategory.categoryID,
      presentBadge: false,
      presentAlert: true, // id
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(notificationID, title, body, notificationDetails,
        payload: customNotificationModel.encodeNotification());
  }

  Future<void> showBigPictureNotificationIos(
      {required int notificationID,
      required String title,
      required String body,
      required String? imageUrl,
      required CustomNotificationModel customNotificationModel}) async {
    List<DarwinNotificationAttachment>? attachments;
    if ((imageUrl ?? "").isNotEmpty) {
      final largeIconPath = await downloadAndSaveImage(imageUrl!);
      attachments = largeIconPath != null
          ? <DarwinNotificationAttachment>[
              DarwinNotificationAttachment(
                largeIconPath,
                hideThumbnail: false,
                thumbnailClippingRect:
                    // lower right quadrant of the attachment
                    const DarwinNotificationAttachmentThumbnailClippingRect(
                  x: 0.5,
                  y: 0.5,
                  height: 0.5,
                  width: 0.5,
                ),
              ),
            ]
          : null;
    }
    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      attachments: attachments,
      threadIdentifier: NotificationChannelID.general.channelID,
      //subtitle: NotificationChannelID.general.channelName,
      categoryIdentifier: NotificationGroupID.commonCategory.categoryID,
      presentBadge: false,
      presentAlert: true, // id
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
    );
    //NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(notificationID, title, body, notificationDetails,
        payload: customNotificationModel.encodeNotification());
  }

  Future<void> showBigPictureNotification(
      {required int notificationID,
      required String title,
      required String body,
      required String? imageUrl,
      required CustomNotificationModel customNotificationModel}) async {
    FilePathAndroidBitmap? largeIconBitMap;
    StyleInformation? styleInformation;
    if ((imageUrl ?? "").isNotEmpty) {
      final largeIconPath = await downloadAndSaveImage(imageUrl!);
      largeIconBitMap = largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null;
    }
    if (largeIconBitMap != null) {
      styleInformation = BigPictureStyleInformation(largeIconBitMap,
          hideExpandedLargeIcon: true,
          contentTitle: '<b>$title</b>',
          htmlFormatContentTitle: true,
          summaryText: '<i>$body</i>',
          htmlFormatSummaryText: true);
    } else {
      styleInformation = BigTextStyleInformation(
        body,
        htmlFormatBigText: true,
        contentTitle: '<b>$title</b>',
        htmlFormatContentTitle: true,
        summaryText: '<i>$body</i>',
        htmlFormatSummaryText: true,
      );
    }
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        NotificationChannelID.general.channelID, NotificationChannelID.general.channelName,
        importance: Importance.max,
        priority: Priority.max,
        setAsGroupSummary: false,
        largeIcon: largeIconBitMap,
        styleInformation: styleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    //NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(notificationID, title, body, notificationDetails,
        payload: customNotificationModel.encodeNotification());
  }
}
/*
final List<DarwinNotificationCategory> darwinNotificationCategories =
<DarwinNotificationCategory>[
  DarwinNotificationCategory(
    "darwinNotificationCategoryText",
    actions: <DarwinNotificationAction>[
      DarwinNotificationAction.text(
        'text_1',
        'Action 1',
        buttonTitle: 'Send',
        placeholder: 'Placeholder',
      ),
    ],
  ),
  DarwinNotificationCategory(
    "darwinNotificationCategoryPlain",
    actions: <DarwinNotificationAction>[
      DarwinNotificationAction.plain('id_1', 'Action 1'),
      DarwinNotificationAction.plain(
        'id_2',
        'Action 2 (destructive)',
        options: <DarwinNotificationActionOption>{
          DarwinNotificationActionOption.destructive,
        },
      ),
      DarwinNotificationAction.plain(
        "navigationActionId",
        'Action 3 (foreground)',
        options: <DarwinNotificationActionOption>{
          DarwinNotificationActionOption.foreground,
        },
      ),
      DarwinNotificationAction.plain(
        'id_4',
        'Action 4 (auth required)',
        options: <DarwinNotificationActionOption>{
          DarwinNotificationActionOption.authenticationRequired,
        },
      ),
    ],
    options: <DarwinNotificationCategoryOption>{
      DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
    },
  )
];
 */
/*
  Future<void> notifyPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }
 */


/*
// // butonlu ve textfield'lı bilidirmleri dinlemek için
class NotificationService {
  static const _channel = MethodChannel('com.example.app/notification_actions');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'notificationAction':
        final Map<String, dynamic> arguments = Map<String, dynamic>.from(call.arguments);

        switch(arguments['actionId']) {
          case 'ACCEPT_ACTION':
            print('Kabul edildi');
            // Kabul işlemlerini yap
            break;

          case 'REJECT_ACTION':
            print('Reddedildi');
            // Red işlemlerini yap
            break;

          case 'TEXT_INPUT_ACTION':
            final String? userText = arguments['userText'];
            print('Kullanıcı yanıtı: $userText');
            // Metin işlemlerini yap
            break;
        }
        break;
    }
  }
}
 */
/*
class NotificationBackgroundService {
  static const _channel = MethodChannel('com.example.app/silent_fcm');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onSilentNotification':
        final Map<String, dynamic> arguments = Map<String, dynamic>.from(call.arguments);
        print(arguments);
        print("onSilentNotification");
      default:
        print('Bildirim geldi');
    }
  }
}
 */