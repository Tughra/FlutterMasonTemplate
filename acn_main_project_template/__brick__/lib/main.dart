import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_file_name}}/core/injectables.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/core/managers/device_info_manager.dart';
import 'package:{{project_file_name}}/core/managers/language_manager.dart';
import 'package:{{project_file_name}}/core/managers/token_manager.dart';
import 'package:{{project_file_name}}/core/managers/version_check_manager.dart';
import 'package:{{project_file_name}}/model_view/app/app_theme.dart';
import 'package:{{project_file_name}}/model_view/common/common_provider.dart';
import 'package:{{project_file_name}}/model_view/user/user_profile_provider.dart';
import 'package:{{project_file_name}}/views/initial/my_app.dart';
import 'package:provider/provider.dart';
import 'core/local_storage/hive.dart';
//import 'firebase_options.dart';
import 'repository/services/config_service.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification == null) {
    /*
    final CustomNotificationModel notificationModel = CustomNotificationModel.fromJson(message.data);
    FlutterLocalNotificationsPlugin().show(notificationModel.uniqueID, notificationModel.title, notificationModel.body,
        NotificationDetails(iOS: getIosNotificationDetail(notificationModel.channelId!), android: getAndroidNotificationDetail(notificationModel.channelId!)),
        payload: notificationModel.encodeNotification()
        //message.notification.android.clickAction;
        );
     */
  }

  // print("==Notification in _firebaseMessagingBackgroundHandler method==");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //todo firebase cli ile otomatik üretmeyi unutma
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheManager.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kReleaseMode)FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  ConfigService().loadConfig(AcnApiEnvironment.prod);
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  VersionManager.instance;
  await StorageManager.initPrefs().then((value) {
    GlobalTokenManager.instance; // for set tokens when initialize
    //LanguageManager.instance; // for set applanguage when initialize
  });
  DeviceInfoManager.instance;
  setupInjectables(LanguageManager.instance.locale);
  //HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      /*
      ChangeNotifierProvider<LanguageTranslationProvider>(
        create: (ctx) => GetIt.instance<LanguageTranslationProvider>(),
      ),
      */
      ChangeNotifierProvider(create:(ctx)=>CommonProvider(),lazy: true,),
      ChangeNotifierProvider(create:(ctx)=>AppThemeProvider(),lazy: false,),
      ChangeNotifierProvider(create:(ctx)=>GetIt.instance<QueueProvider>(),lazy: true,),
      //ChangeNotifierProvider(create:(ctx)=>NotificationProvider(),lazy: false,),
      ChangeNotifierProvider<UserProfileProvider>(
        create: (ctx) => GetIt.instance<UserProfileProvider>(),
        lazy: true,
      ),
      //  ChangeNotifierProvider<LanguageProvider>(create:(ctx)=>LanguageProvider()),
    ],
    child: const MyApp(),
  ));
}
