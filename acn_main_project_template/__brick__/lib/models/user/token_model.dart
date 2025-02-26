class UserTokens {
  String? accessToken;
  String? refreshToken;
  final DateTime? expireDate;

  UserTokens({
    this.accessToken,
    this.refreshToken,
    this.expireDate,
  });

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is UserTokens && accessToken == other.accessToken;
  }

  @override
  int get hashCode => accessToken.hashCode;

  factory UserTokens.fromJson(Map<String, dynamic> json) => UserTokens(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        expireDate: json["expireDate"] == null
            ? null
            : json["expireDate"] == ""
                ? null
                : DateTime.parse(json["expireDate"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expireDate": expireDate?.toIso8601String(),
      };
}

class FcmTokenModel {
  final String token;
  final String userID;
  final String userPhone;
  final String name;
  final String secToken;
  final String appVersion;
  final bool permission;
  final Map<String, dynamic> deviceData;

  FcmTokenModel(
      {required this.permission,
      required this.secToken,
      required this.name,
      required this.userPhone,
      required this.appVersion,
      required this.token,
      required this.userID,
      required this.deviceData});

  Map<String, dynamic> toJson() => {
        "notificationStatus": permission,
        "secToken": secToken,
        "name": name,
        "pid": userPhone,
        "token": token,
        "sid": userID,
        "appVersion": appVersion,
        ...deviceData
      };
}
