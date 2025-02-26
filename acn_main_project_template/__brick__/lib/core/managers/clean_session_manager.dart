import 'package:{{project_file_name}}/core/managers/token_manager.dart';
import 'package:{{project_file_name}}/repository/services/login/login_service.dart';

class SessionManager {
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  static SessionManager get instance => _instance;

  logOut() {}


  /// when terminateSession has error or success use callbacks for navigate or etc.
  Future<void> terminateSession({required Function onError,required Function onSuccess}) async {
    final bool signOutStatus = await LoginService().signOut();
    if (signOutStatus) {
      GlobalTokenManager.instance.clearTokens();
      onSuccess.call();
    }else{
      onError.call();
    }
  }

  Future<void> whenStartSession() async {
  }
}
