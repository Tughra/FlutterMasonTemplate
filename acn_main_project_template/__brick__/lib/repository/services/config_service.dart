import 'package:flutter/foundation.dart';


class ConfigService {

  late final String apiEndpoint;
  ConfigService._privateConstructor();

  static final ConfigService _instance = ConfigService._privateConstructor();

  factory ConfigService() {
    return _instance;
  }

  //todo unutma!! api end pointler buraya yazılacak
  void loadConfig(AcnApiEnvironment apiEnvironment) async {
    switch (apiEnvironment) {
      case AcnApiEnvironment.test:
        debugPrint("Environment is Test");
        apiEndpoint = "";
        break;
      case AcnApiEnvironment.prod:
        debugPrint("Environment is Prod");
        apiEndpoint = "";
        break;
    }
  }
}
enum AcnApiEnvironment { test, prod }
