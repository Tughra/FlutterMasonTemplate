import 'package:flutter/cupertino.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/buttons/main_button.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_appbars/appbar.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/headers/acn_main_header.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/body_wrappers.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/core/services/version_check.dart';
import 'package:{{project_file_name}}/model_view/user/user_profile_provider.dart';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:{{project_file_name}}/views/login_page/login_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MandatoryUpdateDialog extends StatelessWidget {
  final String appUrl;

  const MandatoryUpdateDialog({super.key, required this.appUrl});

  openDialog() {
    Get.dialog(this,
        barrierDismissible: false,
        useSafeArea: false,
        routeSettings: const RouteSettings(name: "/MandatoryUpdateDialog"));
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = (context.width - context.width * .8) / 2;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBarPrimary(
          appBarSize: Size.zero,
          color: context.theme.scaffoldBackgroundColor,
        ),
        body: GlobalPaddingBody(
          hasHorizontal: true,
          hasBottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AcnHeaderWidget.simple(),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      const FittedBox(
                        child: Opacity(
                          opacity: 0.5,
                          child: Icon(
                            Icons.update_rounded,
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ornek Proje uygulamasını kullanmaya devam edebilmeniz için son versiyona güncellemeniz gerekmektedir.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingSize),
                child: MainButton(
                  color: context.theme.primaryColor,
                  titleColor: Colors.white,
                  onPressed: () {
                    launchUrl(Uri.parse(appUrl), mode: LaunchMode.externalApplication);
                  },
                  title: "Güncelle",
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NonMandatoryUpdate extends StatelessWidget {
  final String appUrl;

  const NonMandatoryUpdate({Key? key, required this.appUrl}) : super(key: key);

  showSnack() {
    final context = Get.context;
    if (context != null) {
      showModalBottomSheet(
          constraints: BoxConstraints(minWidth: double.maxFinite, maxHeight: context.height * .85),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          enableDrag: true,
          context: context,
          builder: (context) => this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingSize = (context.width - context.width * .8) / 2;
    return BottomCurved(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      child: GlobalPaddingBody(
        hasHorizontal: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            36.heightIntMargin,
            const Text(
              "Ornek Proje uygulamasının yeni versiyonu mevcut.\nŞimdi güncelleyin.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            36.heightIntMargin,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: MainButton(
                color: context.theme.primaryColor,
                titleColor: Colors.white,
                title: "Güncelle",
                onPressed: () {
                  launchUrl(Uri.parse(appUrl), mode: LaunchMode.externalApplication);
                },
              ),
            ),
            36.heightIntMargin
          ],
        ),
      ),
    );
  }
}

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  openDialog() {
    Get.dialog(this, barrierDismissible: false, useSafeArea: false);
  }

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  final String content = "Bakım çalışmasından dolayı şuan hizmet veremiyoruz. Lütfen daha sonra tekrar deneyiniz.";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const AppBarPrimary(
          appBarSize: Size.zero,
        ),
        body: GlobalPaddingBody(
          hasHorizontal: true,
          hasBottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AcnHeaderWidget.simple(),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        IconsAssets.maintenance,
                        opacity: const AlwaysStoppedAnimation(0.1),
                        //color: Colors.white,
                      ),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                24.heightIntMargin,
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CloseAppDialog extends StatelessWidget {
  const CloseAppDialog({super.key});

  Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child,);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text("Bilgilendirme"),
      content: Text("Çıkmak istediğinizden emin misiniz?"),
      actions: <Widget>[
        adaptiveAction(
          context: context,
          onPressed: () =>Get.back(),
          child: const Text('İptal',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        ),
        adaptiveAction(
          context: context,
          onPressed: () {
            context.read<UserProfileProvider>().signOut(onSuccess: () {
              Get.offAll(() => const LoginPage());
            });
          },
          child:  Text('Çıkış',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red[700])),
        ),
      ],
    );
  }
}

class GeneralControlManager {
  static Future<bool> versionAndAppCheckPersistent() async {
    return await AppCheckService().showDialog();
  }

  static versionAndAppCheckDismissible() async {
    return await AppCheckService().showSnack();
  }
}
