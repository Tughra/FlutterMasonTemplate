import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/core/managers/token_manager.dart';
import 'package:{{project_file_name}}/models/login/login_model.dart';
import 'package:{{project_file_name}}/repository/services/login/login_service.dart';
import 'package:{{project_file_name}}/models/management.dart';
import 'package:{{project_file_name}}/models/user/token_model.dart';
import 'package:{{project_file_name}}/utils/constants/app_consts.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';




class LoginProvider extends ChangeNotifier {
  late final FlutterSecureStorage _secureStorage;

  LoginProvider({required LoginService loginService})
      : _loginService = loginService{
    _secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions);
  }
  final LoginService _loginService;
  String idNumber = "";
  String phoneNumber = "";
  bool showSendOtpButton = false;
  bool _obSecure = true;
  bool _keepOpenSession =
      StorageManager.getBool(AppConstant.keepSessionKey, false);

  bool get keepOpenSession => _keepOpenSession;
  String get ownerLoginPhone => _keepOpenSession?StorageManager.getString(AppConstant.ownerLoginPhoneNumber):"";
  String get ownerLoginPartage => _keepOpenSession?StorageManager.getString(AppConstant.ownerLoginPartageNumber):"";
  set keepOpenSession(bool value) {
    _keepOpenSession = value;
    notifyListeners();
  }

  bool get obSecure => _obSecure;

  set obSecure(bool value) {
    _obSecure = value;
    notifyListeners();
  }

  setShowOtpButton(bool value) {
    showSendOtpButton = value;
    notifyListeners();
  }

  Returner<UserTokens?> _loginReturner =
      Returner(data: null, viewStatus: ViewStatus.stateInitial);
  Returner<LoginResult?> _otpReturner =
      Returner(data: null, viewStatus: ViewStatus.stateInitial);

  Returner<UserTokens?> get loginReturner => _loginReturner;

  Returner<LoginResult?> get otpReturner => _otpReturner;

  Future<Returner<LoginResult?>> getOtp(
      {required String userName, required String password,required bool isOwner}) async {
    idNumber = userName;
    _otpReturner.viewStatus = ViewStatus.stateLoading;
    notifyListeners();
    _otpReturner = await _loginService.getOTP(
        userName: userName, passwordOrNumber: password,isOwner: isOwner); //tryFetch();
    phoneNumber = _otpReturner.data?.result?.mobile ?? "";
    notifyListeners();
    return _otpReturner;
  }

  Future<bool> sendOtp({required String otp}) async {
    _loginReturner=Returner(data: null, viewStatus: ViewStatus.stateLoading);
    notifyListeners();
    final data = await _loginService.sendOTP(
        mobileNumber: phoneNumber,
        userName: idNumber,
        otp:
            otp); //dummySendOTP(userName: idNumber, password: phoneNumber,otp: otp);
    _loginReturner = Returner(data: data, viewStatus: ViewStatus.stateLoaded);
    if (data != null) {
      GlobalTokenManager.instance.setNewTokens(data);
    }
    notifyListeners();
    return _loginReturner.data != null;
  }

  @override
  void dispose() {
    debugShow("Dispose LoginProvider");
    super.dispose();
  }

  IOSOptions _getIOSOptions() =>  const IOSOptions(
       // accountName: DeviceInfoManager.instance.iosDeviceInfo.identifierForVendor
      );

  final AndroidOptions _getAndroidOptions = const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> removeAllStorage() async{
    await _secureStorage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions);
  }

  Future<void> saveLoginInfo(
      {required String userName, required String password}) async {
    try {
      await Future.wait([
        _secureStorage.write(
          key: "userName",
          value: userName.isEmpty ? null : userName,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions,
        ),
        _secureStorage.write(
          key: "password",
          value: password.isEmpty ? null : password,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions,
        )
      ]);
    } catch (e) {
      debugShow(e);
    }
  }
  Future<void> saveLoginOwnerInfo(
      {required String ownerLoginPartageNumber, required String phoneNumber}) async {
    try {
      await Future.wait([
        StorageManager.setString(AppConstant.ownerLoginPartageNumber, ownerLoginPartageNumber),
        StorageManager.setString(AppConstant.ownerLoginPhoneNumber, phoneNumber)
      ]);
    } catch (e) {
      debugShow(e);
    }
  }
  Future<void> removeLoginInfo() async {
    Future.wait([
      _secureStorage.delete(
        key: "userName",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions,
      ),
      _secureStorage.delete(
        key: "password",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions,
      )
    ]);
  }

  Future<String?> get userName => _keepOpenSession?_secureStorage.read(key: "userName"):Future.value("");

  Future<String?> get password => _keepOpenSession?_secureStorage.read(key: "password"):Future.value("");
}

mixin _DummyClass {
  Future<bool> dummyGetOtp() async {
    await Future.delayed(const Duration(seconds: 2));
    //DialogService.instance.showCustomDialog("Bilgilerinizi kontrol edip tekrar deneyiniz");
    return true;
  }

  Future<UserTokens> dummySendOTP(
      {required String userName,
      required String password,
      required String otp}) async {
    await Future.delayed(const Duration(seconds: 1));
    //DialogService.instance.showCustomSnack("Gönderilen OTP kodu eşleşmemektedir. Bilgilerinizi kontrol edip tekrar deneyiniz", allowErrorColor: true, snackPosition: SnackPosition.BOTTOM);
    final token = UserTokens(accessToken: "111111", refreshToken: "222222");
    return token;
  }
}
