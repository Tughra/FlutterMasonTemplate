/*
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sirketim_cebimde/utils/constants/app_consts.dart';
import 'package:sirketim_cebimde/utils/print_log.dart';

import 'shared_preference.dart';

class SecureStorage{

  late final FlutterSecureStorage _secureStorage;

  final AndroidOptions _getAndroidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  IOSOptions _getIOSOptions() =>  const IOSOptions(
    // accountName: DeviceInfoManager.instance.iosDeviceInfo.identifierForVendor
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
  bool _keepOpenSession =
  StorageManager.getBool(AppConstant.keepSessionKey, false);
  bool get keepOpenSession => _keepOpenSession;
  Future<String?> get userName => _keepOpenSession?_secureStorage.read(key: "userName"):Future.value("");

  Future<String?> get password => _keepOpenSession?_secureStorage.read(key: "password"):Future.value("");

}
 */