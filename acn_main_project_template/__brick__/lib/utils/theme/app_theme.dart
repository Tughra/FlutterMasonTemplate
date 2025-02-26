import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  //colorScheme primary text inputun label rengini etkiliyor
  ThemeData getMainTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "Nunito",
      dividerTheme: const DividerThemeData(
          thickness: 1, color: Color.fromRGBO(93, 92, 92, .2)),
      cardTheme:
          const CardTheme(color: Colors.white, surfaceTintColor: Colors.white),

      dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme()),
      colorScheme: const ColorScheme(
          shadow: Color.fromRGBO(93, 92, 92, 1),
          primary: Color(0xFF193663),
          onPrimary: Colors.white,
          surfaceContainerLowest: Color.fromRGBO(231, 231, 231, 1),
          secondary: Color.fromRGBO(193, 192, 201, 1),
          onSecondary: Color.fromRGBO(123, 123, 123, 1),
          primaryContainer: Color.fromRGBO(245, 245, 245, 1),
          onPrimaryContainer: Colors.black,
          secondaryContainer: Color.fromRGBO(93, 92, 92, 1),
          onSecondaryContainer: Colors.white,
          surface: Colors.white,
          onSurface: Color.fromRGBO(58, 58, 58, 1),
          error: Color.fromRGBO(230, 0, 22, 1),
          onError: Colors.white,
          brightness: Brightness.light),
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Color.fromRGBO(123, 123, 123, 1))),
      secondaryHeaderColor: const Color.fromRGBO(52, 60, 106, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      primaryColor: const Color.fromRGBO(247, 93, 95, 1),
      primaryColorDark: const Color.fromRGBO(181, 69, 70, 1),
      primaryColorLight: const Color.fromRGBO(247, 124, 125, 1),
      splashColor: const Color.fromRGBO(248, 249, 250, 1),
      //Color(0xFF443737),
      iconTheme: const IconThemeData(color: Color.fromRGBO(93, 92, 92, 1)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(247, 93, 95, 1),
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          titleMedium: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
          titleSmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
          bodyLarge:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          displayMedium:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(245, 245, 245, 1),
              statusBarBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          centerTitle: true,
          color: Color.fromRGBO(247, 93, 95, 1)),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "Nunito",
      dividerTheme: const DividerThemeData(
          thickness: 1, color: Color.fromRGBO(180, 179, 179, .2)),cardTheme: const CardTheme(
        color: Color.fromRGBO(58, 58, 58, 1),
        surfaceTintColor: Color.fromRGBO(58, 58, 58, 1)),
      dropdownMenuTheme: const DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme()),
      colorScheme: const ColorScheme(
          shadow: Color.fromRGBO(180, 179, 179, 1),
          primary: Color.fromRGBO(24,20, 243, 1),
          onPrimary: Colors.white,
          surfaceContainerLowest: Color.fromRGBO(58, 58, 58, 1),
          secondary: Color.fromRGBO(180, 179, 179, 1),
          onSecondary: Color.fromRGBO(123, 123, 123, 1),
          primaryContainer: Color.fromRGBO(58, 58, 58, 1),
          onPrimaryContainer: Colors.white,
          secondaryContainer: Color.fromRGBO(93, 92, 92, 1),
          onSecondaryContainer: Colors.white,
          surface: Color.fromRGBO(58, 58, 58, 1),
          onSurface: Colors.white,
          error: Color.fromRGBO(230, 0, 22, 1),
          onError: Colors.white,
          brightness: Brightness.dark),
      inputDecorationTheme: const InputDecorationTheme(fillColor: Color.fromRGBO(58, 58, 58, 1),
          hintStyle: TextStyle(color: Color.fromRGBO(180, 179, 179, 1))),
      secondaryHeaderColor: const Color.fromRGBO(52, 60, 106, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(34, 34, 34, 1),
      primaryColor: const Color.fromRGBO(247, 93, 95, 1),
      primaryColorDark: const Color.fromRGBO(181, 69, 70, 1),
      primaryColorLight: const Color.fromRGBO(247, 124, 125, 1),
      splashColor: const Color.fromRGBO(58, 58, 58, 1),
      //Color(0xFF443737),
      iconTheme: const IconThemeData(color: Color.fromRGBO(180, 179, 179, 1)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(247, 93, 95, 1),
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          titleMedium: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
          titleSmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          bodyLarge: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          displayMedium:
          TextStyle(fontWeight: FontWeight.normal, color: Colors.white)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color.fromRGBO(34, 34, 34, 1),
              statusBarBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Color.fromRGBO(58, 58, 58, 1),
              statusBarIconBrightness: Brightness.light),
          centerTitle: true,
          color: Color.fromRGBO(247, 93, 95, 1)),
    );
  }
}