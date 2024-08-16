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

  String get deleteCategory => Intl.message('Delete Category', name: 'deleteCategory');

  String deleteCategoryConfirmation(String category) => Intl.message(
    'Are you sure you want to delete the category \'$category\' and all its phrases?',
    name: 'deleteCategoryConfirmation',
    args: [category],
  );

  String get cancel => Intl.message('Cancel', name: 'cancel');

  String get delete => Intl.message('Delete', name: 'delete');

  String categoryDeleted(String category) => Intl.message(
    'Category \'$category\' has been deleted',
    name: 'categoryDeleted',
    args: [category],
  );

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

  /// `Add Phrase`
  String get addPhrase {
    return Intl.message(
      'Add Phrase',
      name: 'addPhrase',
      desc: '',
      args: [],
    );
  }

  /// `New Phrase`
  String get newPhrase {
    return Intl.message(
      'New Phrase',
      name: 'newPhrase',
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

  /// `New Category`
  String get newCategory {
    return Intl.message(
      'New Category',
      name: 'newCategory',
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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Hold to remove all`
  String get removeMessage {
    return Intl.message(
      'Hold to remove all',
      name: 'removeMessage',
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
