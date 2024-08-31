import 'package:flutter/material.dart';

class LocalizationsData {
  LocalizationsData._();

  // static Language getUserDeviceLanguage() {
  //   String defaultLocale = Platform.localeName;
  //   defaultLocale = defaultLocale.split('_').firstOrNull ?? '';
  //   Language lang = Language.values.firstWhere((element) => element.langCode == defaultLocale);
  //   printWarning("Default Locale: $defaultLocale");
  //   return lang;
  // }

  ///* Supported Localization `List<Locale>[]`
  static List<Locale> supportedLanguages = const [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];

  static Locale arabicLocale = const Locale('ar', 'SA');
  static Locale englishLocale = const Locale('en', 'US');
}
