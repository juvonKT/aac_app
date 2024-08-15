import 'package:flutter/material.dart';
import 'package:aac_app/generated/l10n.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en', '');

  Locale get currentLocale => _currentLocale;

  void setLocale(Locale locale) {
    if (!S.delegate.supportedLocales.contains(locale)) return;
    _currentLocale = locale;
    notifyListeners();
  }
}