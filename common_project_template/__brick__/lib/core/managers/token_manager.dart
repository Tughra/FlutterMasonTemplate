import 'package:flutter/foundation.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/models/user/token_model.dart';

class GlobalTokenManager {
  static final GlobalTokenManager _instance = GlobalTokenManager._init();
  static GlobalTokenManager get instance => _instance;
  final UserTokens _userTokens = UserTokens();

  UserTokens get userTokens => _userTokens;

  GlobalTokenManager._init() {
    debugPrint("Initialize and set tokens");
    _userTokens.accessToken = StorageManager.getAccessToken();
    _userTokens.refreshToken = StorageManager.getAccessToken();
  }
  setNewTokens(UserTokens token) {
    _userTokens.accessToken = token.accessToken;
    _userTokens.refreshToken = token.refreshToken;
  }

  setNewForPersistentToken(UserTokens token) {
    StorageManager.setRefreshToken(token.refreshToken??"");
    StorageManager.setAccessToken(token.accessToken??"");
  }

  clearTokens() {
    _userTokens.accessToken = "";
    _userTokens.refreshToken = "";
    StorageManager.clearTokens();
  }
}
