import 'dart:convert';
import 'package:{{project_file_name}}/models/login/login_model.dart';
import 'package:{{project_file_name}}/models/management.dart';
import 'package:{{project_file_name}}/models/user/token_model.dart';
import 'package:{{project_file_name}}/repository/services/config_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class LoginService {
  //Options(headers: {"App-Version": VersionManager.instance.version, "Device-Name": Platform.isIOS ? "IOS" : "ANDROID"})
  final Duration _timeoutDuration = const Duration(seconds: 60);
  late final String _endPoint = "${ConfigService().apiEndpoint}api/";

  LoginService({Dio? dio}) {

    if(dio==null){
      _dio = Dio(
        BaseOptions(
          headers: {"lang": "tr"},
          contentType: 'application/json',
          connectTimeout: _timeoutDuration,
          receiveTimeout: _timeoutDuration,
          sendTimeout: _timeoutDuration,
        ),
      )    ..interceptors.add(InterceptorsWrapper(
        onRequest: (req, handler) {
          debugPrint("From Interceptor Request");
          debugPrint(req.data.toString());
          debugPrint(req.path.toString());
          debugPrint(req.queryParameters.toString());
          return handler.next(req);
        },
        onResponse: (response, responseHandler) {
          debugPrint("From Interceptor Response");
          debugPrint(response.statusCode.toString());
          debugPrint(response.data.toString());
          return responseHandler.resolve(response);
        },
        onError: (err, handler) async {
          try{
            debugPrint("From Interceptor Error");
            debugPrint(err.response.toString());
            if (err.response?.statusCode != null && err.response!.statusCode! >= 500) {
              final String errPath = "Request error from = ${err.requestOptions.path}";
              final String reqBody = "Request Body = ${err.requestOptions.data.toString()}";
              final String errResponse = "Request response = ${err.response.toString()}";
              final String errStatus = "Request response = ${err.response?.statusCode.toString()}";
              FirebaseCrashlytics.instance.recordError(err,err.stackTrace,information: [errPath,reqBody,errStatus,errResponse,]);
            }
            return handler.next(err);
          }catch(_){
            return handler.next(err);
          }

        },
      ));
    }else{
      _dio = dio ;
    }

  }

  late final Dio _dio;

  Future<Returner<LoginResult>> getOTP({required String userName, required String passwordOrNumber,required bool isOwner}) async {
    try {
      late final bodyData = {"userName": userName};
      if(isOwner){
        bodyData["mobile"]="90$passwordOrNumber";
      }else{
        bodyData["password"]=passwordOrNumber;
      }
      final Response response = await _dio.post(
        '${_endPoint}Account/GetCustomerInfo',data: bodyData
      );
      final data = LoginResult.fromJson(response.data);
      if(data.result!=null) {
        if(data.type==1) {
          return Returner(data:data, viewStatus: ViewStatus.stateLoaded);
        }else{
          return Returner(data:data, viewStatus: ViewStatus.stateError,errorMessage:data.message??"Bir sorun oluştu. Lütfen tekrar deneyin.");
        }
      }else{
        return Returner(data:data, viewStatus: ViewStatus.stateError);
      }
    } catch (e) {
      return Returner(data: LoginResult(message: "Bir sorun oluştu. Lütfen tekrar deneyin."), viewStatus: ViewStatus.stateError);
    }
  }

  Future<UserTokens?> sendOTP({required String userName,required String mobileNumber, required String otp}) async {
    try {
      Response response =
          await _dio.post('${_endPoint}Account/VerifyOtp',data: {"userName":userName,"otp": otp, "mobile": mobileNumber});
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data is String ? jsonDecode(response.data) : response.data ?? {};
        UserTokens userTokens = UserTokens.fromJson(jsonData["result"]);
        if(userTokens.accessToken!=null){
          return userTokens;
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      //Response response = await NetworkManager.instance.dio.get('${AppConstant.mainUrl}/core/user-management/users/me/registration-status');
      const statusCode = 200;
      if (statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
