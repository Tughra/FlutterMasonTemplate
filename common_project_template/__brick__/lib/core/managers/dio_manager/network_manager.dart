import 'package:{{project_file_name}}/model_view/user/user_profile_provider.dart';
import 'package:{{project_file_name}}/utils/print_log.dart';
import 'package:{{project_file_name}}/views/login_page/login_page.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:{{project_file_name}}/core/managers/token_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';

class NetworkManager extends Interceptor {
  late Dio dio;
  final Duration _timeoutDuration = const Duration(seconds: 180);
  static final NetworkManager _instance = NetworkManager._init();

  static NetworkManager get instance {
    return _instance;
  }

  NetworkManager._init() {
    dio = Dio(
      BaseOptions(
          headers: {"lang": "tr"},
          contentType: 'application/json',
          connectTimeout: _timeoutDuration,
          receiveTimeout: _timeoutDuration,
          sendTimeout: _timeoutDuration),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (err, handler) {
          debugPrint("🌐❌🌐From Interceptor Error ------------------------------------------>");
          ColoredLogger.log("From Interceptor Response",level: LogLevel.NetworkInfo);
          ColoredLogger.log("Url: ${err.requestOptions.uri.toString()}",level: LogLevel.NetworkInfo);
          ColoredLogger.log("Message: ${err.message.toString()}",level: LogLevel.NetworkInfo);
          ColoredLogger.log("Response: ${err.response?.data.toString()}",level: LogLevel.NetworkInfo);
          debugPrint("<------------------------------------------");
          if (err.response?.statusCode == 401) {
            if (Get.currentRoute != "/LoginPage") {
              GetIt.instance<UserProfileProvider>().signOutForce(onSuccess: () {
                Get.offAll(() => const LoginPage(
                      rootExitType: ExitType.terminateSession,
                    ));
              });
            }
            return handler.reject(DioException(
              type: err.type,
              requestOptions: err.requestOptions,
              message: "Access token expired",
              error: 'The session is expired',
            ));
          } else {
            if (err.response?.statusCode != null && err.response!.statusCode! >= 500) {
              final String errPath = "Request error from = ${err.requestOptions.path}";
              final String reqBody = "Request Body = ${err.requestOptions.data.toString()}";
              final String errResponse = "Request response = ${err.response.toString()}";
              final String errStatus = "Request response = ${err.response?.statusCode.toString()}";
              FirebaseCrashlytics.instance.recordError(err, err.stackTrace, information: [
                errPath,
                reqBody,
                errStatus,
                errResponse,
              ]);
            }
            if (err.type == DioExceptionType.cancel) {
              return handler.reject(DioException(
                type: err.type,
                requestOptions: err.requestOptions,
                message: "Access token expired",
                error: 'The session is expired',
              ));
            } else {
              return handler.resolve(err.response ??
                  Response(statusCode: 404, statusMessage: "No Response", requestOptions: RequestOptions(responseType: ResponseType.json)));
            }
          }
        },
        onRequest: (req, handler) {
          debugPrint("From Interceptor Request");
          debugPrint(req.data.toString());
          debugPrint(req.path.toString());
          debugPrint(req.queryParameters.toString());
          if (GlobalTokenManager.instance.userTokens.accessToken != null && GlobalTokenManager.instance.userTokens.accessToken != '') {
            req.headers['Authorization'] = 'Bearer ${GlobalTokenManager.instance.userTokens.accessToken}';
          }
          return handler.next(req);
        },
        onResponse: (response, responseHandler) {
          ColoredLogger.log("From Interceptor Response",level: LogLevel.NetworkInfo);
          ColoredLogger.log("Url: ${response.realUri.toString()}",level: LogLevel.NetworkInfo);
          ColoredLogger.log("Status: ${response.statusCode.toString()}",level: LogLevel.NetworkInfo);
          ColoredLogger.log("Response: ${response.data.toString()}",level: LogLevel.NetworkInfo);
          return responseHandler.resolve(response);
        },
      ),
    );
  }
}

/*
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
 */

/*
 try {
            debugPrint('${err.response?.data.toString()}');
            if (err.response?.realUri.toString() ==
                '${AppConstant.mainUrl}/token/refresh') {
              try {
                if (err.response?.statusCode != 201) {
                  SessionManager.instance.terminateSession();
                }
              } catch (e, s) {
                debugPrint(s.toString());
              }
            }
            if (err.response?.statusCode == 500) {
              handler.resolve(err.response!);
            }

            if (err.response?.statusCode == 401) {
              if (err.response?.data["message"] == "Refresh token expired") {
                SessionManager.instance.terminateSession();
              } else {
                await dio
                    .post('${AppConstant.mainUrl}/token/refresh',
                        data: jsonEncode({
                          "refresh_token": GlobalTokenManager
                              .instance.userTokens.refreshToken
                        }))
                    .then((value) async {
                  final Map<String, dynamic> jsonData = value.data is String
                      ? jsonDecode(value.data)
                      : value.data;
                  if (value.statusCode == 201) {
                    GlobalTokenManager.instance.userTokens.refreshToken =
                        jsonData["refresh_token"];
                    GlobalTokenManager.instance.userTokens.accessToken =
                        jsonData["access_token"];
                   /*
                    StorageManager.setRefreshToken(
                        GlobalTokenManager.instance.userTokens.refreshToken);
                    StorageManager.setAccessToken(
                        GlobalTokenManager.instance.userTokens.accessToken);
                    */
                    err.requestOptions.headers["Authorization"] =
                        "Bearer ${GlobalTokenManager.instance.userTokens.accessToken!}";
                    final opts = Options(
                        method: err.requestOptions.method,
                        headers: err.requestOptions.headers);
                    final response = await dio.request(err.requestOptions.path,
                        options: opts,
                        data: err.requestOptions.data,
                        queryParameters: err.requestOptions.queryParameters);
                    return handler.resolve(response);

                    /// En son gelen 401 isteğin kopyasını otomatik gönderir.
                  } else if (value.statusCode == 401) {}
                });
              }
            }
            return handler.next(err);
          } catch (e, s) {
            debugPrint('${e.toString()}, ${s.toString()}');
            return handler.next(err);
          }
 */
/*
Dio(
    BaseOptions(
      headers: {"lang": "tr"},
      contentType: 'application/json',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
    ),
  )..interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (req, handler) {
        debugPrint("From Interceptor Request");
        debugPrint(req.data.toString());
        debugPrint(req.path.toString());
        debugPrint(req.queryParameters.toString());
        /*
        cancel token mantıkları
        req.cancelToken=cancelToken;
        if(cancelToken.isCancelled==true&&userKicked==false) {
          print("cancel yenile");
          cancelToken = CancelToken();
          req.cancelToken=cancelToken;
        }
         */
        return handler.next(req);
      },
      onError: (err, handler) async {
        print("onError Dio");
        print(err.response?.statusCode);
        try {
          if (err.response?.statusCode == 401) {
            if(Get.currentRoute!="/LoginPage") {
              GetIt.instance<UserProfileProvider>().signOutForce(onSuccess: () {
              Get.offAll(() => const LoginPage(
                isTerminateSession: true,
              ))!.then((_) => print("Complete off"));
              userKicked = false;
            });
            }
            /*
            cancel token mantıkları
             if(userKicked==false) {
             print(err.requestOptions.cancelToken==null);
             print(err.requestOptions.cancelToken?.isCancelled);
             cancelToken.cancel();
             userKicked = true;
             Future.delayed(const Duration(milliseconds: 500),(){
              GetIt.instance<UserProfileProvider>().signOutForce(onSuccess: () {
                Get.offAll(() => const LoginPage(
                  isTerminateSession: true,
                ))!.then((_) => print("Complete off"));
                userKicked = false;
              });
            });
           }
             */
            return handler.reject(DioException(
              type: DioExceptionType.cancel,
              requestOptions: err.requestOptions,
              message: "Access token expired",
              error: 'The session is expired',
            ));
          } else {
            return handler.resolve(
                err.response ?? Response(statusCode: 404, statusMessage: "No Response", requestOptions: RequestOptions(responseType: ResponseType.json)));
          }
        } catch (_) {
          return handler.next(err);
        }
      },
    ))
 */
