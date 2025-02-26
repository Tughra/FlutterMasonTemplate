import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';

class LanguageManager {
  late Locale locale;
  LanguageManager._init() {
    final lang = StorageManager.getAppLanguage();
    if (lang != "") {
      List<String> splitLang = lang.split("_");
      if (splitLang.length > 1) {
        locale = Locale(splitLang.first, splitLang.last);
      } else {
        final currentLang = _getCurrentLang.split("_");
        if (currentLang.length > 1) {
          locale = Locale(currentLang.first, currentLang.last);
        } else {
          locale = Get.deviceLocale ?? const Locale("en", "US");
        }
      }
    } else {
      final currentLang = _getCurrentLang.split("_");
      if (currentLang.length > 1) {
        locale = Locale(currentLang.first, currentLang.last);
      } else {
        locale = Get.deviceLocale ?? const Locale("en", "US");
      }
    }
  }
  static LanguageManager get instance => _instance ??= LanguageManager._init();

  static LanguageManager? _instance;

  String get _getCurrentLang => Platform.localeName;

  Future<void> setAppLanguage(String selectedLocale) async {
    await StorageManager.setAppLanguage(selectedLocale);
    final lang = StorageManager.getAppLanguage();
    List<String> splitLang = lang.split("_");
    locale = Locale(splitLang.first, splitLang.last);
  }
}

/*
    static const langAssetPath = 'assets/translations';
  final dlLocale = const Locale('en', 'US'); // necessary
  final enLocale = const Locale('en');
  final trLocale = const Locale('tr');

  List<Locale> get supportedLocales => [dlLocale, enLocale, trLocale];

  // constants
  static const supportedLanguages = ['en', 'tr'];

  Locale getCurrentLocale() {
    return supportedLanguages.contains(getCurrentLang)
        ? Locale(getCurrentLang)
        : const Locale('en');
  }
   */
