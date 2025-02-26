import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/utils/constants/values_manager.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/buttons/main_button.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_appbars/appbar.dart';

class PermissionDialogPage extends StatelessWidget {
  final PermissionType permissionType;
  final bool hasCloseButton;

  static Future<dynamic> openPermission(PermissionType permissionType, {bool hasCloseButton = true}) async {
    return await Get.dialog(
        PermissionDialogPage(
          permissionType: permissionType,
          hasCloseButton: hasCloseButton,
        ),
        useSafeArea: false);
  }

  const PermissionDialogPage({super.key, required this.permissionType, this.hasCloseButton = true});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(hasCloseButton);
      },
      child: Scaffold(
        appBar:  AppBarPrimary(
          appBarSize: Size.zero,
          color: Theme.of(context).primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(
              flex: 5,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                _iconDataType(permissionType),
                size: context.width / 3,
                color: context.theme.primaryColor,
              ),
            ),
            //  const Spacer(flex: 1,),
            Column(
              children: [
                Text(
                  _titleAndContent(permissionType).first,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 24),
                ),
                AppPadding.standardMinBody.heightDoubleMargin,
                Text(
                  _titleAndContent(permissionType).last,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 16),
                )
              ],
            ),
            const Spacer(
              flex: 8,
            ),
            MainButton(
              title: 'Ayarlar',
              onPressed: () {
                if (permissionType == PermissionType.gallery) {
                  AppSettings.openAppSettings().then((value) => Navigator.of(context).pop());
                } else if (permissionType == PermissionType.locationService) {
                  AppSettings.openAppSettings();
                } else if (permissionType == PermissionType.location) {
                  AppSettings.openAppSettings();
                } else {
                  AppSettings.openAppSettings().then((value) => Navigator.of(context).pop());
                }
              },
            ),
            AppPadding.standardMinBody.heightDoubleMargin,
            Visibility(
              visible: hasCloseButton,
              child: GestureDetector(
                  onTap: () {
                    Get.close(1);
                  },
                  child: const Text(
                    'Kapat',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 16),
                  )),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

enum PermissionType { camera, gallery, mic, location, locationService,storage}

IconData _iconDataType(PermissionType permissionType) {
  switch (permissionType) {
    case PermissionType.camera:
      return Icons.camera_alt_outlined;
    case PermissionType.gallery:
      return Icons.photo;
    case PermissionType.mic:
      return Icons.mic_none;
    case PermissionType.location:
      return Icons.location_on_outlined;
    case PermissionType.locationService:
      return Icons.location_on_outlined;
    case PermissionType.storage:
      return Icons.storage;
  }
}

List<String> _titleAndContent(PermissionType permissionType) {
  switch (permissionType) {
    case PermissionType.camera:
      return ["Kamera", "Kamera izni vermelisiniz"];
    case PermissionType.gallery:
      return ["Galeri", "Galeri izni vermelisiniz"];
    case PermissionType.mic:
      return ["Mikrofon", "Mikrofon izni veermelisiniz"];
    case PermissionType.location:
      return ["Konum", "Konum izni vermelisiniz"];
    case PermissionType.locationService:
      return ["Konum", "Konum izni vermelisiniz"];
    case PermissionType.storage:
      return ["Depolama", "Depolama izni vermelisiniz"];
  }
}

/*
class _CupertinoWidget extends StatelessWidget {
  final String title;
  final String content;
  final PermissionType permissionType;

  const _CupertinoWidget({Key? key, required this.title, required this.content, required this.permissionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('user.common.btn_close'.translateMap()),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
            child: Text('user.common.btn_settings'.translateMap()),
            onPressed: () {
              if (permissionType == PermissionType.gallery) {
                AppSettings.openAppSettings().then((value) => Navigator.of(context).pop());
              } else if (permissionType == PermissionType.location) {
                AppSettings.openAppSettings();
              } else {
                AppSettings.openAppSettings().then((value) => Navigator.of(context).pop());
              }
            }
            // () => AppSettings.openNotificationSettings(asAnotherTask: true),

            ),
      ],
    );
  }
}

class _AlertWidget extends StatelessWidget {
  final String title;
  final String content;
  final PermissionType permissionType;

  const _AlertWidget({Key? key, required this.title, required this.content, required this.permissionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      content: Text(content),
      actions: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: CupertinoDialogAction(
                child: Text('user.common.btn_close'.translateMap()),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
              width: 100,
              child: CupertinoDialogAction(
                child: Text('user.common.btn_settings'.translateMap()),
                onPressed: () {
                  if (permissionType == PermissionType.gallery) {
                    AppSettings.openAppSettings().then((value) => Navigator.of(context).pop());
                  } else if (permissionType == PermissionType.location) {
                    AppSettings.openAppSettings();
                  } else {
                    AppSettings.openAppSettings().then((value) => Navigator.of(context).pop());
                  }
                },
                //onPressed: () => openAppSettings().then((value) => Navigator.of(context).pop()),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PermissionAlert extends StatelessWidget {
  final String title;
  final String content;
  final PermissionType permissionType;

  const PermissionAlert({Key? key, required this.title, required this.content, required this.permissionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? _AlertWidget(
            title: title,
            content: content,
            permissionType: permissionType,
          )
        : _CupertinoWidget(title: title, content: content, permissionType: permissionType);
  }
}
 */
