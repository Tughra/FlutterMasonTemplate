import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' show debugPrint, kReleaseMode;

void debugShow(Object? object) {
  debugPrint(object.toString());
}

void debugShowLong(Object object) {
  if (!kReleaseMode) developer.log(object.toString());
}
enum LogLevel {
  Debug,
  Info,
  Warning,
  Error,
  NetworkInfo,
}
class ColoredLogger {
  static void log(
      dynamic message, {
        LogLevel level = LogLevel.Info,
        String? tag,
      }) {
    if (kReleaseMode) return;

    final DateTime now = DateTime.now();
    final String timestamp = "${now.hour}:${now.minute}:${now.second}";
    final String tagString = tag != null ? '[$tag]' : '';

    String emoji;
    switch (level) {
      case LogLevel.Debug:
        emoji = '🔍';
      case LogLevel.Info:
        emoji = 'ℹ️';
      case LogLevel.Warning:
        emoji = '⚠️';
      case LogLevel.Error:
        emoji = '❌';
      case LogLevel.NetworkInfo:
        emoji = '🌐';
    }

    debugShow('$emoji [$timestamp]${tagString}: $message');
  }
}

void assertLog(dynamic message, {String? tag}) {
  assert(() {
    ColoredLogger.log(message, tag: tag, level: LogLevel.Debug);
    return true;
  }());
}
/*
class ColoredLogger {
  static void log(dynamic message, {
    LogLevel level = LogLevel.Info,
    String? tag,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) return;
    final DateTime now = DateTime.now();
    final String timestamp = "${now.hour}:${now.minute}:${now.second}";

    String colorCode;
    String prefix;

    switch (level) {
      case LogLevel.Debug:
        colorCode = '\x1B[37m'; // White
        prefix = 'DEBUG';
      case LogLevel.Info:
        colorCode = '\x1B[32m'; // Green
        prefix = 'INFO';
      case LogLevel.Warning:
        colorCode = '\x1B[33m'; // Yellow
        prefix = 'WARN';
      case LogLevel.Error:
        colorCode = '\x1B[31m'; // Red
        prefix = 'ERROR';
    }

    final String tagString = tag != null ? '[$tag]' : '';
    final String formattedMessage = '$colorCode[$timestamp][$prefix]$tagString: $message\x1B[0m';

    developer.log(
      formattedMessage,
      stackTrace: stackTrace,
      time: now,
      level: level.index,
    );
  }
}
 */