import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/route_manager.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:{{project_file_name}}/views/common/control_app.dart';
import 'package:{{project_file_name}}/views/common/page_connectivity.dart';
import 'package:{{project_file_name}}/views/initial/landing_page.dart';
import 'package:{{project_file_name}}/views/login_page/login_page.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_appbars/appbar.dart';
import 'package:{{project_file_name}}/core/extensions/context_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasConnection = true;
  final connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> connectStream;

  @override
  void initState() {
    getStarted();
    super.initState();
  }

  /*
  void fetchData() {
    context.read<CommonProvider>().getContactNumber();
  }
   */

  void getStarted() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      precacheImage(const AssetImage(LogosAssets.appLogo), context);
      hasConnection = !(await connectivity.checkConnectivity()).contains(ConnectivityResult.none);
      setState(() {});
      connectStream = connectivity.onConnectivityChanged.listen((event) {
        if (!event.contains(ConnectivityResult.none)) {
          setState(() {
            hasConnection = true;
          });

          GeneralControlManager.versionAndAppCheckPersistent().then((value) async {
            if (value) {
              if (StorageManager.getLandingShow()) {
                Future.microtask(() => Get.off(() => const LoginPage()));
              } else {
                Future.microtask(() => Get.off(() => const LandingPage()));
              }
            }
          });
        } else {
          setState(() {
            hasConnection = false;
          });
        }
      });
      /*
      final fetchStatue = await context.read<LanguageTranslationProvider>().fetchLanguageBody();
      //final bool hasLoginBefore = GlobalTokenManager.instance.userTokens.accessToken != null;
      if (fetchStatue) {
        //NotificationService.instance;
        Get.off(() => const LoginPage());
      }
       */
    });
  }

  void initialRoute() async {}

  @override
  void dispose() {
    connectStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPrimary(
        toolbarHeight: 0,
        appBarSize: Size.zero,
      ),
      body: Center(
        child: hasConnection == false
            ? PageFailConnection(
                onRefresh: () async {
                  connectivity.checkConnectivity().then((value) {
                    if (!value.contains(ConnectivityResult.none)) {
                      setState(() {
                        hasConnection = true;
                      });
                      initialRoute();
                    } else {
                      setState(() {
                        hasConnection = false;
                      });
                    }
                  });
                },
              )
            : Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset(
                  LogosAssets.appLogo,
                  width: context.width * .6,
                  errorBuilder: (_, __, ___) => SizedBox(
                      width: 200,
                      child: Image.asset(
                        LogosAssets.appLogo,
                        fit: BoxFit.contain,
                      )),
                  fit: BoxFit.cover,
                ))),
      ),
    );
  }
}
/*
Consumer<LanguageTranslationProvider>(
                    builder: (context, state, child) {
                      if (state.languageReturner.viewStatus == ViewStatus.stateError) {
                        return UnloadedPage(onPressed: getStarted);
                      } else {
                        return child!;
                      }
                    },
                    child: Center(
                      child: Image.asset(
                        LogosAssets.appLogo,
                        width: context.width * .8,
                        height: context.height * .8,
                      ),
                    ))
 */
