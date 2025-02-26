import 'package:{{project_file_name}}/utils/constants/app_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageManager {
  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> initPrefs() async {
    _prefs = await _instance;
    return _prefs;
  }

  static String? getAccessToken() {
    return _prefs?.getString(AppConstant.accessToken);
  }

  static String? getRefreshToken() {
    return _prefs?.getString(AppConstant.refreshToken);
  }

  static bool getOtherButtonShow(){
    return _prefs?.getBool(AppConstant.otherButtonShown) ?? false;
  }
  static void setOtherButtonShow()async{
      _prefs?.setBool(AppConstant.otherButtonShown,true);
  }
  static bool getLandingShow(){
    return _prefs?.getBool(AppConstant.landingPageShow) ?? false;
  }
  static void setLandingShow()async{
    _prefs?.setBool(AppConstant.landingPageShow,true);
  }
  /*
  static Future<bool> setCoachShown(
      {required String homePage,
      required String listPage,
      required String detailPage}) async {
    /// control as bool string isShown="true", notShown="false"
    var prefs = await _instance;
    return prefs
        .setStringList(AppConstant.coachShow, [homePage, listPage, detailPage]);
  }
  static List<String> getCoachShown() {
    /// control as bool string isShown="true", notShown="false"
    return _prefs?.getStringList(AppConstant.coachShow) ??
        ["false", "false", "false"];
  }
   */

  static int? getContractId() {
    return _prefs?.getInt(AppConstant.contractID);
  }

  static String getString(String key, [String? defValue]) {
    return _prefs?.getString(key) ?? defValue ?? '';
  }
  static bool getBool(String key, [bool? defValue]) {
    return _prefs?.getBool(key) ?? defValue ?? false;
  }
  static Future<bool> setBool(String key,bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }
  static String getAppLanguage() {
    return _prefs?.getString(AppConstant.appLanguage) ?? '';
  }

  static Future<bool> setAccessToken(String value) async {
    var prefs = await _instance;
    return prefs.setString(AppConstant.accessToken, value);
  }

  static Future<bool> setRefreshToken(String value) async {
    var prefs = await _instance;
    return prefs.setString(AppConstant.refreshToken, value);
  }

  static Future<bool> setAppLanguage(String value) async {
    var prefs = await _instance;
    return prefs.setString(AppConstant.appLanguage, value);
  }


  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static void clearTokens() async {
    await _prefs?.remove(AppConstant.accessToken);
    await _prefs?.remove(AppConstant.refreshToken);
  }

  static void clearAll() {
    _prefs?.clear();
  }
}
