
class AppCheckModel {
  final MaintenanceModel? maintenance;
  final DeviceCheckModel? ios;
  final DeviceCheckModel? android;

  AppCheckModel({
    this.maintenance,
    this.ios,
    this.android,
  });

  factory AppCheckModel.fromJson(Map<String, dynamic> json) => AppCheckModel(
    maintenance: json["maintenance"] == null ? null : MaintenanceModel.fromJson(json["maintenance"]),
    ios: json["ios"] == null ? null : DeviceCheckModel.fromJson(json["ios"]),
    android: json["android"] == null ? null : DeviceCheckModel.fromJson(json["android"]),
  );

  Map<String, dynamic> toJson() => {
    "maintenance": maintenance?.toJson(),
    "ios": ios?.toJson(),
    "android": android?.toJson(),
  };

  int get versionNumberIos => ios?.version!=null?int.parse(ios!.version!.split(".").join()):0;
  int get versionNumberAndroid => android?.version!=null?int.parse(android!.version!.split(".").join()):0;
}

class DeviceCheckModel {
  final String? version;
  final bool? mandatory;
  final String? appUrl;

  DeviceCheckModel({
    this.version,
    this.mandatory,
    this.appUrl,
  });

  factory DeviceCheckModel.fromJson(Map<String, dynamic> json) => DeviceCheckModel(
    version: json["version"],
    mandatory: json["mandatory"],
    appUrl: json["appUrl"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "mandatory": mandatory,
    "appUrl": appUrl,
  };
}

class MaintenanceModel {
  final bool? popup;

  MaintenanceModel({
    this.popup,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) => MaintenanceModel(
    popup: json["popup"],
  );

  Map<String, dynamic> toJson() => {
    "popup": popup,
  };
}
