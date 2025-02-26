import 'dart:async';
import 'package:{{project_file_name}}/core/managers/token_manager.dart';
import 'package:{{project_file_name}}/model_view/common/common_provider.dart';
import 'package:{{project_file_name}}/models/login/login_model.dart';
import 'package:flutter/widgets.dart';
import 'package:{{project_file_name}}/core/managers/clean_session_manager.dart';
import 'package:get_it/get_it.dart';

class UserProfileProvider extends ChangeNotifier with _UserProfileMixin {
  int _userAgencyCode = -1;
  String _userGsm = "";
  String _userAgencyName = "";
  String _userName = "";
  String _userCitizenShipNo = "";
  String _userLoginName = "";
  int? _userGender;
  bool _isOwner = false;
  String _userMaskedGsm = "";
  String _userMaskedAgencyName = "";
  String _userExpertusToken = "";

  int? get userGender => _userGender;

  String get userLoginName => _userLoginName;

  String get userName => _userName;

  String get userCitizenShipNo => _userCitizenShipNo;

  String get userMaskedGsm => _userMaskedGsm;

  String get userMaskedAgencyName => _userMaskedAgencyName;

  String get userGsm => _userGsm;

  int get userAgencyCode => _userAgencyCode;

  String get userAgencyName => _userAgencyName;

  String get userExpertusToken => _userExpertusToken;

  bool get userIsOwner => _isOwner;

  //called at home navigator initState
  Completer<bool> _authCompleter = Completer<bool>();

  Completer<bool> get authCompleter => _authCompleter;

  void setUserDetail(
      {required LoginDataModel loginData, required String loginName}) async {
    _userName = loginData.userName ?? "";
    _userCitizenShipNo = loginData.citizenShipNo ?? "";
    _userGender = loginData.gender;
    _userGsm = loginData.mobile!;
    _userExpertusToken = loginData.expertusToken ?? "";
    //todo expertus token null veya boş gelince bir mantık yaz
    _userAgencyName = loginData.agencyName ?? "";
    _userAgencyCode = loginData.agencyCode!;
    _userMaskedGsm = loginData.maskedMobile ?? "0**********";
    _userMaskedAgencyName = loginData.maskedUserName!;
    _userLoginName = loginName;
    _isOwner = loginData.isOwner;
    _authCompleter.complete(true);
  }

  void _resetSetUserDetail() {
    _userGsm = "";
    _userAgencyName = "";
    _userAgencyCode = -1;
    _userExpertusToken = "";
    _userCitizenShipNo = "";
    _userLoginName = "";
    _isOwner = false;
  }

  Future<void> signOut({Function? onError, Function? onSuccess}) async {
    _signOutStatus = true;
    notifyListeners();
    await SessionManager.instance.terminateSession(onError: () {
      onError?.call();
    }, onSuccess: () {
      _resetSetUserDetail();
      GetIt.instance<QueueProvider>().disposeProcesses();
      onSuccess?.call();
    });
    _authCompleter = Completer<bool>();
    _signOutStatus = false;
    notifyListeners();
  }

  bool get isAuth =>
      (GlobalTokenManager.instance.userTokens.accessToken ?? "").isNotEmpty;

  signOutForce({Function? onError, Function? onSuccess}) {
    SessionManager.instance.terminateSession(onError: () {
      onError?.call();
    }, onSuccess: () {
      _resetSetUserDetail();
      GetIt.instance<QueueProvider>().disposeProcesses();
      _authCompleter = Completer<bool>();
      onSuccess?.call();
    });
  }
}

mixin _UserProfileMixin {
  //final userRepo = UserProfileService.instance;
  bool _signOutStatus = false;

  bool get signOutStatus => _signOutStatus;
}
