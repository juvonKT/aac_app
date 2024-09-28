import 'package:flutter/material.dart';
import 'package:aac_app/generated/l10n.dart';
import 'user_provider.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _currentLocale;

  Locale get currentLocale => _currentLocale ?? const Locale('en', '');

  void setLocale(Locale locale) {
    if (!S.delegate.supportedLocales.contains(locale)) return;
    _currentLocale = locale;
    notifyListeners();
  }

  Future<void> loadUserLanguage(UserProvider userProvider) async {
    String languageCode = userProvider.getLanguageCode();
    setLocale(Locale(languageCode));
  }
}