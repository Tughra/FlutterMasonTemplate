import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_file_name}}/core/services/anlytics.dart';
import 'package:{{project_file_name}}/utils/constants/app_consts.dart';
import 'package:{{project_file_name}}/utils/theme/app_theme.dart';
import 'package:{{project_file_name}}/views/initial/splash_screen.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();
class MyApp extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  /*
   static Future<void> setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    Get.updateLocale(newLocale);
    state?.changeLanguage(newLocale);
  }
   */
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }
  @override
  void initState() {
    super.initState();
  }

  /*
  changeLanguage(Locale locale) {
    setState(() {
      context.setLocale(locale);
    });
  }
   */
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(scaffoldMessengerKey:rootScaffoldMessengerKey ,
      defaultTransition: Transition.noTransition,
      key: key,
      color:const Color.fromRGBO(247, 93, 95, 1) ,
      opaqueRoute: false,
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: AppTheme().getMainTheme(),

      locale:  PlatformDispatcher.instance.locales.first,
      //fallbackLocale: context.fallbackLocale,
      //supportedLocales: context.supportedLocales,
      //routingCallback: (route){
      //         print(route?.previous);
      //         print(route?.current);
      //         print("========");
      //       },
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        // ... app-specific localization delegate(s) here
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      navigatorObservers: [
        GetIt.instance<AnalyticsService>().getAnalyticsObserver()
        //  FirebaseAnalyticsService().appAnalyticsObserver(),
      ],
      builder: (context,child)=>MediaQuery(data: MediaQuery.of(context).copyWith(devicePixelRatio: 1, textScaler: const TextScaler.linear(1)), child: child!),
      home: const SplashScreen(),
    );
  }
}