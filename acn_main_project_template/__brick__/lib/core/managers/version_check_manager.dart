import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionManager {
  static final VersionManager _instance = VersionManager._init();
  late final PackageInfo _packageInfo;
  String _appName = "";

  String _packageName = "";

  String _version = "";

  String _buildNumber = "";

  PackageInfo get packageInfo => _packageInfo;

  VersionManager._init() {
    _initialize();
  }
  _initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _appName = _packageInfo.appName;
    _packageName = _packageInfo.packageName;
    _version = _packageInfo.version;
    _buildNumber = _packageInfo.buildNumber;
    debugPrint(
        "Version Manager initialized\n appName:$appName\n packageName:$packageName\n version:$version\n buildNumber:$buildNumber");
  }

  static VersionManager get instance => _instance;

  String get appName => _appName;

  String get packageName => _packageName;

  String get version => _version;

  int get versionNumber => _version.isNotEmpty?int.parse(_version.split(".").join()):0;

  String get buildNumber => _buildNumber;
}
