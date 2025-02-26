import 'package:firebase_analytics/firebase_analytics.dart';
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void setCurrentPage(String screenClass,String pageName){
    _analytics.logScreenView(screenClass: screenClass,screenName:pageName);
  }

  /*
   Future setUserProperties({required String userId, String userRole}) async {
    await _analytics.setUserId(userId);
    // Set the user_role
    await _analytics.setUserProperty(name: 'user_role', value: userRole);
  }
   */
}

//firebase crashlytics:symbols:upload --app=FIREBASE_APP_ID PATH/TO/symbols