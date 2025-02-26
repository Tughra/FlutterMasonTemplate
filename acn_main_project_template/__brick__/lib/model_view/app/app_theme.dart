import 'package:flutter/material.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/utils/constants/app_consts.dart';
import 'package:{{project_file_name}}/utils/theme/app_theme.dart';

class AppThemeProvider extends ChangeNotifier{
  final String _mainThemeKey = "mainTheme";
  final String _darkThemeKey = "darkTheme";

  ThemeData get appTheme =>currentIsDark?AppTheme().getDarkTheme():AppTheme().getMainTheme();
  bool currentIsDark = false;
  AppThemeProvider(){
    currentIsDark = StorageManager.getString(AppConstant.appTheme,_mainThemeKey)==_darkThemeKey;
  }
  void changeTheme(){
    currentIsDark=!currentIsDark;
    notifyListeners();
    StorageManager.setString(AppConstant.appTheme, currentIsDark==true?_darkThemeKey:_mainThemeKey);
  }
}