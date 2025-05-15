import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoManager {
  static DeviceInfoManager? _instance;
  late final DeviceInfoPlugin _deviceInfo;
  late final AndroidDeviceInfo _androidDeviceInfo;
  late final IosDeviceInfo _iosDeviceInfo;
  late final SendDeviceInfo sendDeviceInfo;

  DeviceInfoManager._init() {
    _initialize();
  }

  static DeviceInfoManager get instance => _instance ??= DeviceInfoManager._init();

  AndroidDeviceInfo get androidDeviceInfo => _androidDeviceInfo;

  IosDeviceInfo get iosDeviceInfo => _iosDeviceInfo;
  bool _isBiggerIos12 = false;
  bool _isLessThanAndroid13 = false;

  bool get isBiggerIos12 => _isBiggerIos12;

  bool get isLessThanAndroid13 => _isLessThanAndroid13;

  _initialize() async {
    _deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfo.iosInfo;
      _isBiggerIos12 = _parseIosVersion(_iosDeviceInfo.systemVersion) > 12;
      sendDeviceInfo = SendDeviceInfo(
        engineName: "Ios",
        sdkVersion: _iosDeviceInfo.utsname.machine,
        deviceVersion: _iosDeviceInfo.systemVersion,
        brand: _iosDeviceInfo.name,
        model: _iosDeviceInfo.systemVersion,
        devicePixel: "",
        isPhysical: _iosDeviceInfo.isPhysicalDevice,
      );
    } else {
      _androidDeviceInfo = await _deviceInfo.androidInfo;
      _isLessThanAndroid13 = _androidDeviceInfo.version.sdkInt < 33;
      sendDeviceInfo = SendDeviceInfo(
        engineName: "Android",
        sdkVersion: androidDeviceInfo.version.sdkInt.toString(),
        deviceVersion: androidDeviceInfo.version.release,
        brand: _androidDeviceInfo.brand,
        model: _androidDeviceInfo.model,
        devicePixel: _androidDeviceInfo.display,
        isPhysical: _androidDeviceInfo.isPhysicalDevice,
      );
    }
  }

  int _parseIosVersion(String? versionName) {
    List<String> version = [];
    if (versionName != null) {
      version = versionName.split(".");
    }
    int? number = int.tryParse(version.isNotEmpty ? version.first : "0");
    return number ?? 0;
  }

  /*
  getInfo() {
    if (Platform.isAndroid) {
      print('Device Name: ${androidDeviceInfo.device.toString()}');
      //print('')
      print('Device Model: ${androidDeviceInfo.model.toString()}');
      print('Device Manufacturer: ${androidDeviceInfo.manufacturer.toString()}');
      print('Android Version: ${androidDeviceInfo.version.release.toString()}');
      print('Sdk Version: ${androidDeviceInfo.version.sdkInt.toString()}');
      print('Device Type: ${androidDeviceInfo.isPhysicalDevice ? 'Fiziksel' : 'Sanal'}');
    } else {
      print('Device version: ${_iosDeviceInfo.systemVersion}');
      print('Device version: ${_iosDeviceInfo.utsname.machine}');
    }
  }
   */
}

class SendDeviceInfo {
  final String engineName;
  final String deviceVersion;
  final String sdkVersion;
  final String brand;
  final String model;
  final String devicePixel;
  final bool isPhysical;

  SendDeviceInfo(
      {required this.engineName,
      required this.deviceVersion,
      required this.sdkVersion,
      required this.brand,
      required this.model,
      required this.devicePixel,
      required this.isPhysical});

  Map<String, dynamic> toJson() => {
        "engineName": engineName,
        "versionSDK": sdkVersion,
        "deviceBrand": brand,
        "deviceModel": model,
        "isPhysicalDevice": isPhysical,
        "devicePixel": devicePixel,
        "deviceVersion": deviceVersion
      };
}
