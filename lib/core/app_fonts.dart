import 'package:flutter/material.dart';

class AppFonts {
  AppFonts._();

  static const String arabic = 'Almarai';
  static const String english = 'RobotoCondensed';

  static String family(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? arabic : english;
  }

  static String fromLocale(Locale locale) {
    return locale.languageCode == 'ar' ? arabic : english;
  }

  static bool isArabic(Locale locale) {
    return locale.languageCode == 'ar';
  }
}
