import 'dart:convert';
import 'dart:io';
import 'package:{{project_file_name}}/core/managers/version_check_manager.dart';
import 'package:{{project_file_name}}/models/global/app_check_model.dart';
import 'package:{{project_file_name}}/repository/services/config_service.dart';
import 'package:{{project_file_name}}/views/common/control_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pub_semver/pub_semver.dart';


//todo unutma!! android ve ios url ekle.
const String _androidUrl = "";
const String _iosUrl = "";
class AppCheckService {
  static AppCheckModel? appCheckModel;
  final _isAndroid = Platform.isAndroid;
  final String endPoint = ConfigService().apiEndpoint;
  //called from splash screen
  Future<bool> showDialog() async {
    appCheckModel = await checkVersion();
    bool shouldPass = true;
    try{
      if (appCheckModel != null) {
        if (appCheckModel!.maintenance?.popup == true) {
          const MaintenancePage().openDialog();
          shouldPass = false;
        } else {
          switch (_isAndroid) {
            case true:
              final Version version1 = Version.parse(appCheckModel!.android!.version!);
              final Version version2 = Version.parse(VersionManager.instance.version);
              if (version2<version1) {
                if (appCheckModel!.android!.mandatory == true) {
                  final url = (appCheckModel?.android?.appUrl ?? "").isEmpty
                      ? _androidUrl
                      : appCheckModel!.android!.appUrl!;
                  MandatoryUpdateDialog(
                    appUrl: url,
                  ).openDialog();
                  shouldPass = false;
                }
              }
              break;
            case false:
              final Version version1 = Version.parse(appCheckModel!.ios!.version!);
              final Version version2 = Version.parse(VersionManager.instance.version);
              if (version2<version1) {
                if (appCheckModel!.ios!.mandatory == true) {
                  final url =
                  (appCheckModel?.ios?.appUrl ?? "").isEmpty ? _iosUrl : appCheckModel!.ios!.appUrl!;
                  MandatoryUpdateDialog(
                    appUrl: url,
                  ).openDialog();
                  shouldPass = false;
                }
              }
          }
        }
      }
      return shouldPass;
    }catch(_){
      return true;
    }

  }

  //called from  home screen
  showSnack() {
    if (appCheckModel != null) {
      switch (_isAndroid) {
        case true:
          final Version version1 = Version.parse(appCheckModel!.android!.version!);
          final Version version2 = Version.parse(VersionManager.instance.version);
          if (version2<version1) {
            if (appCheckModel!.android!.mandatory == false) {
              final url = (appCheckModel?.android?.appUrl ?? "").isEmpty
                  ? _androidUrl
                  : appCheckModel!.android!.appUrl!;
              NonMandatoryUpdate(
                appUrl: url,
              ).showSnack();
            }
          }
          break;
        case false:
          final Version version1 = Version.parse(appCheckModel!.ios!.version!);
          final Version version2 = Version.parse(VersionManager.instance.version);
          if (version2<version1) {
            if (appCheckModel!.ios!.mandatory == false) {
              final url =
              (appCheckModel?.ios?.appUrl ?? "").isEmpty ? _iosUrl : appCheckModel!.ios!.appUrl!;
              NonMandatoryUpdate(
                appUrl: url,
              ).showSnack();
            }
          }
      }
    }
  }

  Future<AppCheckModel?> checkVersion() async {
    try {
      final response = await Dio(BaseOptions(receiveTimeout: const Duration(seconds: 20))).get(
        "${endPoint}api/Management",
      );
      if (response.statusCode == 200) {
        debugPrint("checkVersion complete");
        Map<String, dynamic>? data = response.data is String ? jsonDecode(response.data) : response.data;
        if (data != null) {
          return AppCheckModel.fromJson(data);
        } else {
          return null;
        }
      } else {
        debugPrint("checkVersion error");
        return null;
      }
    } catch (e) {
      debugPrint("checkVersion ${e.toString()}");
      return null;
    }
  }
}