import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LifeCycleObserver {
  static LifeCycleObserver? _instance;
  static DateTime? _scenePausedTime;

  factory LifeCycleObserver() {
    _instance ??= LifeCycleObserver._();
    return _instance!;
  }

  LifeCycleObserver._() {
    _init();
  }

  StreamSubscription<AppLifecycleState>? _cycleSubscription;
  static AppLifecycleState lifecycleState = AppLifecycleState.resumed;
  BehaviorSubject<AppLifecycleState> lifeCycleObserver = BehaviorSubject<AppLifecycleState>()..value = AppLifecycleState.resumed;

  kickTheUser(Function onKick) {
    _cycleSubscription ??= lifeCycleObserver.listen((value) {
      switch (value) {
        case AppLifecycleState.resumed:
          // print("resumed");
          if (_scenePausedTime != null) {
            if (DateTime.now().difference(_scenePausedTime!).inMinutes >= 20) {
              _scenePausedTime = null;
              onKick();
            }
          }
          break;
        case AppLifecycleState.detached:
          //   print("detached");
          break;
        case AppLifecycleState.hidden:
          // print("hidden");
          break;
        case AppLifecycleState.inactive:
          //print("inactive");
          break;
        case AppLifecycleState.paused:
          _scenePausedTime = DateTime.now();
        //print("paused at $_scenePausedTime");
      }
    });
  }
  _init() {
    if (lifeCycleObserver.isClosed) lifeCycleObserver.startWith(AppLifecycleState.resumed);
  }

  dispose() {
    lifeCycleObserver.close();
    _cycleSubscription = null;
    _instance = null;
  }
}

class TrackTheRoute {
  static String bottomNavigatorRoute = "";
}
