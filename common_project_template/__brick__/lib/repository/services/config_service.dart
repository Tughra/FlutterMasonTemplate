import 'package:flutter/foundation.dart';

class ConfigService {
  /// test endPoint = https://testmobileservices.acnturk.com.tr/
  ///
  /// prod endPoint = https://mobileservices.acnturk.com.tr/
  late final String apiEndpoint;
  //late final String mdtApiEndpoint;
  //late final String mdtServiceApiEndpoint;

  ConfigService._privateConstructor();

  static final ConfigService _instance = ConfigService._privateConstructor();

  factory ConfigService() {
    return _instance;
  }

  /// test endPoint = https://testmobileservices.acnturk.com.tr/
  ///
  /// prod endPoint = https://mobileservices.acnturk.com.tr/
  void loadConfig(AcnApiEnvironment apiEnvironment) async {
    switch (apiEnvironment) {
      case AcnApiEnvironment.test:
        debugPrint("Environment is Test");
        apiEndpoint = "https://agencymobile.acnturk.com.tr/";
        //mdtApiEndpoint = "https://test.acnturk.com.tr/";
        //mdtServiceApiEndpoint = "https://test.acnturk.com.tr/";
        break;
      case AcnApiEnvironment.prod:
        debugPrint("Environment is Prod");
        apiEndpoint = "https://apigw.acnturk.com.tr/gateway/Internal.AgencyMobile/1.0/";
        //mdtApiEndpoint = "https://gate.acnturk.com.tr/";
        //mdtServiceApiEndpoint = "https://acnturk.com.tr/";
        break;
    }
  }
}
//https://apigw.acnturk.com.tr/gateway/Internal.AgencyMobile/1.0/
enum AcnApiEnvironment { test, prod }
