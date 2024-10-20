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

  /// `Delete Category`
  String get deleteCategory {
    return Intl.message(
      'Delete Category',
      name: 'deleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the category '{category}' and all its phrases?`
  String deleteCategoryConfirmation(Object category) {
    return Intl.message(
      'Are you sure you want to delete the category \'$category\' and all its phrases?',
      name: 'deleteCategoryConfirmation',
      desc: '',
      args: [category],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Category '{category}' has been deleted`
  String categoryDeleted(Object category) {
    return Intl.message(
      'Category \'$category\' has been deleted',
      name: 'categoryDeleted',
      desc: '',
      args: [category],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
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

  /// `Add New User`
  String get addNewUser {
    return Intl.message(
      'Add New User',
      name: 'addNewUser',
      desc: '',
      args: [],
    );
  }

  /// `Delete User`
  String get deleteUser {
    return Intl.message(
      'Delete User',
      name: 'deleteUser',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `AddUser`
  String get addUserButton {
    return Intl.message(
      'AddUser',
      name: 'addUserButton',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete '{phrase}'?`
  String deletePhraseConfirmation(Object phrase) {
    return Intl.message(
      'Are you sure you want to delete \'$phrase\'?',
      name: 'deletePhraseConfirmation',
      desc: '',
      args: [phrase],
    );
  }

  /// `Delete Phrase`
  String get deletePhrase {
    return Intl.message(
      'Delete Phrase',
      name: 'deletePhrase',
      desc: '',
      args: [],
    );
  }

  /// `Select User`
  String get selectUser {
    return Intl.message(
      'Select User',
      name: 'selectUser',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete '{user}'?`
  String deleteUserConfirmation(Object user) {
    return Intl.message(
      'Are you sure you want to delete \'$user\'?',
      name: 'deleteUserConfirmation',
      desc: '',
      args: [user],
    );
  }

  /// `Past`
  String get past {
    return Intl.message(
      'Past',
      name: 'past',
      desc: '',
      args: [],
    );
  }

  /// `Progressive`
  String get progressive {
    return Intl.message(
      'Progressive',
      name: 'progressive',
      desc: '',
      args: [],
    );
  }

  /// `No starting words available.`
  String get noStartingWords {
    return Intl.message(
      'No starting words available.',
      name: 'noStartingWords',
      desc: '',
      args: [],
    );
  }

  /// `What is this app for?`
  String get purposeTitle {
    return Intl.message(
      'What is this app for?',
      name: 'purposeTitle',
      desc: '',
      args: [],
    );
  }

  /// `This app is designed to help users, especially those with communication challenges, construct sentences using predefined phrases. It also offers features like phrase suggestions, multiple languages, and text-to-speech to assist users in effective communication.`
  String get purposeContent {
    return Intl.message(
      'This app is designed to help users, especially those with communication challenges, construct sentences using predefined phrases. It also offers features like phrase suggestions, multiple languages, and text-to-speech to assist users in effective communication.',
      name: 'purposeContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Add a User`
  String get addUserTitle {
    return Intl.message(
      'How to Add a User',
      name: 'addUserTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Navigate to the Settings page.\n2. Tap on the 'Add New User' button.\n3. Enter the user’s name and save.`
  String get addUserContent {
    return Intl.message(
      '1. Navigate to the Settings page.\n2. Tap on the \'Add New User\' button.\n3. Enter the user’s name and save.',
      name: 'addUserContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Delete a User`
  String get deleteUserTitle {
    return Intl.message(
      'How to Delete a User',
      name: 'deleteUserTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Navigate to the Settings page.\n2. Select the user you wish to delete from the list.\n3. Tap the 'Delete User' button.`
  String get deleteUserContent {
    return Intl.message(
      '1. Navigate to the Settings page.\n2. Select the user you wish to delete from the list.\n3. Tap the \'Delete User\' button.',
      name: 'deleteUserContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Change Language`
  String get changeLanguageTitle {
    return Intl.message(
      'How to Change Language',
      name: 'changeLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Go to the Settings page.\n2. Under 'Language', select your preferred language from the dropdown.\n3. The app will automatically switch to the selected language.`
  String get changeLanguageContent {
    return Intl.message(
      '1. Go to the Settings page.\n2. Under \'Language\', select your preferred language from the dropdown.\n3. The app will automatically switch to the selected language.',
      name: 'changeLanguageContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Change the Theme`
  String get changeThemeTitle {
    return Intl.message(
      'How to Change the Theme',
      name: 'changeThemeTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Navigate to Settings.\n2. Under 'Colour Scheme', choose between light or dark mode.`
  String get changeThemeContent {
    return Intl.message(
      '1. Navigate to Settings.\n2. Under \'Colour Scheme\', choose between light or dark mode.',
      name: 'changeThemeContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Use Phrases`
  String get usePhrasesTitle {
    return Intl.message(
      'How to Use Phrases',
      name: 'usePhrasesTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Navigate to the main phrase screen.\n2. Choose a category or start typing a phrase.\n3. The app will suggest phrases based on what you've selected.`
  String get usePhrasesContent {
    return Intl.message(
      '1. Navigate to the main phrase screen.\n2. Choose a category or start typing a phrase.\n3. The app will suggest phrases based on what you\'ve selected.',
      name: 'usePhrasesContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Add a New Phrase or Category`
  String get addPhraseTitle {
    return Intl.message(
      'How to Add a New Phrase or Category',
      name: 'addPhraseTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Go to the Settings page.\n2. Tap '+'.\n3. Enter the details and save.`
  String get addPhraseContent {
    return Intl.message(
      '1. Go to the Settings page.\n2. Tap \'+\'.\n3. Enter the details and save.',
      name: 'addPhraseContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Delete a Phrase or Category`
  String get deletePhraseTitle {
    return Intl.message(
      'How to Delete a Phrase or Category',
      name: 'deletePhraseTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Navigate to the main phrase screen.\n2. Long press on the category or phrase you want to delete.\n3. A pop-up message will ask for confirmation. Select 'Delete' to remove it.`
  String get deletePhraseContent {
    return Intl.message(
      '1. Navigate to the main phrase screen.\n2. Long press on the category or phrase you want to delete.\n3. A pop-up message will ask for confirmation. Select \'Delete\' to remove it.',
      name: 'deletePhraseContent',
      desc: '',
      args: [],
    );
  }

  /// `How to Use Text-to-Speech`
  String get useTTSTitle {
    return Intl.message(
      'How to Use Text-to-Speech',
      name: 'useTTSTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. On the Home page near top right corner.\n2. Tap the speaker icon after putting phrases in the field text to hear the phrase spoken aloud.`
  String get useTTSContent {
    return Intl.message(
      '1. On the Home page near top right corner.\n2. Tap the speaker icon after putting phrases in the field text to hear the phrase spoken aloud.',
      name: 'useTTSContent',
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
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ms'),
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
