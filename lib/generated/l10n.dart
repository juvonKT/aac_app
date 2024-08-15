// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `User Guide`
  String get userGuide {
    return Intl.message(
      'User Guide',
      name: 'userGuide',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Colour Scheme`
  String get colourScheme {
    return Intl.message(
      'Colour Scheme',
      name: 'colourScheme',
      desc: '',
      args: [],
    );
  }

  /// `User A`
  String get userA {
    return Intl.message(
      'User A',
      name: 'userA',
      desc: '',
      args: [],
    );
  }

  /// `User B`
  String get userB {
    return Intl.message(
      'User B',
      name: 'userB',
      desc: '',
      args: [],
    );
  }

  /// `User C`
  String get userC {
    return Intl.message(
      'User C',
      name: 'userC',
      desc: '',
      args: [],
    );
  }

  /// `Add word`
  String get addWord {
    return Intl.message(
      'Add word',
      name: 'addWord',
      desc: '',
      args: [],
    );
  }

  /// `Speak`
  String get speak {
    return Intl.message(
      'Speak',
      name: 'speak',
      desc: '',
      args: [],
    );
  }

  /// `Name of Category`
  String get nameOfCategory {
    return Intl.message(
      'Name of Category',
      name: 'nameOfCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add to field text`
  String get addFieldText {
    return Intl.message(
      'Add to field text',
      name: 'addFieldText',
      desc: '',
      args: [],
    );
  }

  /// `Go to Category`
  String get goToCategory {
    return Intl.message(
      'Go to Category',
      name: 'goToCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add Phrase`
  String get addPhrase {
    return Intl.message(
      'Add Phrase',
      name: 'addPhrase',
      desc: '',
      args: [],
    );
  }

  /// `Create New Phrase`
  String get createNewPhrase {
    return Intl.message(
      'Create New Phrase',
      name: 'createNewPhrase',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Create New Category`
  String get createNewCategory {
    return Intl.message(
      'Create New Category',
      name: 'createNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `User Guide Content Goes Here`
  String get userGuideContent {
    return Intl.message(
      'User Guide Content Goes Here',
      name: 'userGuideContent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
