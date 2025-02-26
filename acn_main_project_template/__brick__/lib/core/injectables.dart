import 'dart:ui';
import 'package:{{project_file_name}}/model_view/common/common_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_file_name}}/model_view/user/user_profile_provider.dart';
import 'services/anlytics.dart';
//import 'package:sirketim_cebimde/src/language_translation.dart';

void setupInjectables(Locale appLocale) {
  //final locale = appLocale;
  GetIt.instance.registerLazySingleton<UserProfileProvider>(() => UserProfileProvider());
  GetIt.instance.registerLazySingleton<QueueProvider>(() => QueueProvider());
  GetIt.instance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
//  GetIt.instance.registerLazySingleton<OnlineUserProvider>(() => OnlineUserProvider());
// Alternatively you could write it if you don't like global variables
//  GetIt.I.registerSingleton<AppModel>(AppModel());
}
