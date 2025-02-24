
class LoginResult {
  final LoginDataModel? result;
  final int? type;
  final String? message;

  LoginResult({
    this.result,
    this.type,
    this.message,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    result: json["result"] == null ? null : LoginDataModel.fromJson(json["result"]),
    type: json["type"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "type": type,
    "message": message,
  };
}

class LoginDataModel {
  final String? userName;
  final String? mobile;
  final String? maskedUserName;
  final String? maskedMobile;
  final String? expertusToken;
  final String? citizenShipNo;
  final String? agencyName;
  final String? agencyRegion;
  final int? agencyCode;
  final int? gender;
  final bool isOwner;

  LoginDataModel({
    this.userName,
    this.citizenShipNo,
    this.agencyName,
    this.gender,
    this.mobile,
    this.maskedUserName,
    this.agencyRegion,
    this.maskedMobile,
    this.agencyCode,
    this.expertusToken,
    this.isOwner=false,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
    userName: json["userName"],
    citizenShipNo: json["citizenShipNo"],
    agencyName: json["agencyName"],
    gender: json["gender"],
    mobile: json["mobile"],
    maskedUserName: json["maskedUserName"],
    maskedMobile: json["maskedMobile"],
    agencyCode: json["agencyCode"],
    agencyRegion: json["agencyRegion"],
    expertusToken: json["expertusToken"],
    isOwner: json["isOwner"]??false,
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "mobile": mobile,
    "maskedUserName": maskedUserName,
    "maskedMobile": maskedMobile,
    "agencyCode": agencyCode,
    "expertusToken": expertusToken,
  };
}
