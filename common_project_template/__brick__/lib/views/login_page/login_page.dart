import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:{{project_file_name}}/core/managers/version_check_manager.dart';
import 'package:{{project_file_name}}/core/notifications/cloud_notification_service.dart';
import 'package:{{project_file_name}}/core/notifications/notification_permission.dart';
import 'package:{{project_file_name}}/core/services/dialog_service.dart';
import 'package:{{project_file_name}}/model_view/user/login_provider.dart';
import 'package:{{project_file_name}}/repository/services/login/login_service.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/views/common/control_app.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

enum ExitType { terminateSession, authorizationChange, standard }

class LoginPage extends StatefulWidget {
  final ExitType rootExitType;

  const LoginPage({
    Key? key,
    this.rootExitType = ExitType.standard,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final loginProvider = LoginProvider(
      loginService: LoginService(dialogService: DialogService.instance));
  bool isShowedSnack = false;
  bool sessionTerminate = false;

  @override
  void initState() {
    super.initState();
    sessionTerminate = widget.rootExitType == ExitType.terminateSession;
    WidgetsBinding.instance.addObserver(this);
    CheckNotificationPermission.instance.checkPermission().then(
            (value) => CloudNotificationService.cloudNotificationServiceInitialize);
    rootReason();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      GeneralControlManager.versionAndAppCheckDismissible();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        widget.rootExitType == ExitType.terminateSession &&
        isShowedSnack == false) {
      isShowedSnack = true;
      Future.delayed(
          const Duration(seconds: 1),
              () => DialogService.instance.showCustomSnack(
              "Oturumunuz sonlandırıldı. Lütfen tekrar giriş yapınız.",
              snackStyle: SnackStyle.GROUNDED));
    }
  }

  void rootReason() {
    switch (widget.rootExitType) {
      case ExitType.terminateSession:
        if (sessionTerminate) {
          Get.closeAllSnackbars();
          Future.delayed(
              const Duration(milliseconds: 500),
                  () => DialogService.instance.showCustomSnack(
                  "Oturumunuz sonlandırıldı. Lütfen tekrar giriş yapınız.",
                  snackStyle: SnackStyle.GROUNDED));
          sessionTerminate = false;
          isShowedSnack = true;
        }
      case ExitType.authorizationChange:
        Future.delayed(
            const Duration(milliseconds: 500),
                () => DialogService.instance.showCustomSnack(
                "Yetkileriniz değiştirildi. Lütfen tekrar giriş yapınız.",
                snackStyle: SnackStyle.GROUNDED));
      case ExitType.standard:
        return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (context) => loginProvider,
        builder: (context, _) => DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: AppColor.primaryColor,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark),
              toolbarHeight: 12,
            ),
            body: WillPopScope(
              onWillPop: () async {
                // Minimize the app instead of closing it
                SystemNavigator.pop();
                return false;
              },
              child: Column(
                children: [
                  if (VersionManager.instance.version.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          "V: ${VersionManager.instance.version}",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
