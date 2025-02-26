import 'dart:async';
import 'package:{{project_file_name}}/core/managers/device_info_manager.dart';
import 'package:{{project_file_name}}/widget_dialogs/dialogs/permission_alerts.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  PermissionStatus? _statusCamera;
  PermissionStatus? _statusMic;
  PermissionStatus? _statusStorage;
  StreamSubscription? sceneListener;

  PermissionStatus? get statusStorage => _statusStorage;

  _cameraPermissionStatue() async {
    _statusCamera = await Permission.camera.request();
    //statusMic=await Permission.microphone.status;
    //if(statusMic!=PermissionStatus.granted) Permission.microphone.request();
  }

  _micPermissionStatue() async {
    _statusMic = await Permission.microphone.request();
  }

  Future<bool> filePermission() async {
    if(DeviceInfoManager.instance.isLessThanAndroid13){
      _statusStorage = await Permission.storage.request();
      final value = (_statusStorage == PermissionStatus.limited) || (_statusStorage == PermissionStatus.granted);
      if (value==false) {
        await PermissionDialogPage.openPermission(PermissionType.storage, hasCloseButton: true).then((value) => sceneListener?.cancel());
      }
      return value;
    }else {
      return Future.value(true);
    }

  }

  Future<bool> checkPermissionForVideoCalling() async {
    await _cameraPermissionStatue();
    await _micPermissionStatue();
    bool enableAll = false;
    if (_statusCamera != PermissionStatus.granted) {
      await PermissionDialogPage.openPermission(PermissionType.camera, hasCloseButton: false).then((value) => sceneListener?.cancel());
      /*
      await Get.dialog(PermissionAlert(
        permissionType: PermissionType.camera,
        title: "permission.camera.title".tr(),
        content: "permission.camera.content".tr(),
      ));
       */
    }
    if (_statusMic != PermissionStatus.granted) {
      await PermissionDialogPage.openPermission(PermissionType.mic, hasCloseButton: false).then((value) => sceneListener?.cancel());
      /*
            await Get.dialog(PermissionAlert(
        permissionType: PermissionType.mic,
        title: "permission.mic.title".tr(),
        content: "permission.mic.content".tr(),
      ));
       */
    } else {
      enableAll = true;
    }
    return enableAll;
  }
}
