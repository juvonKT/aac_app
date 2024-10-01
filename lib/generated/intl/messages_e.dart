// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a e locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'e';

  static String m0(category) => "Category \'${category}\' has been deleted";

  static String m1(category) =>
      "Are you sure you want to delete the category \'${category}\' and all its phrases?";

  static String m2(phrase) => "Are you sure you want to delete \'${phrase}\'?";

  static String m3(user) => "Are you sure you want to delete \'${user}\'?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
        "addNewUser": MessageLookupByLibrary.simpleMessage("Add New User"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("Add Phrase"),
        "addPhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. Go to the Settings page.\n2. Tap \'Add Phrase\' or \'Add Category.\'\n3. Enter the details and save."),
        "addPhraseTitle": MessageLookupByLibrary.simpleMessage(
            "How to Add a New Phrase or Category"),
        "addUserButton": MessageLookupByLibrary.simpleMessage("AddUser"),
        "addUserContent": MessageLookupByLibrary.simpleMessage(
            "1. Navigate to the Settings page.\n2. Tap the \'Add User\' button.\n3. Enter the user’s name and save."),
        "addUserTitle":
            MessageLookupByLibrary.simpleMessage("How to Add a User"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "categoryDeleted": m0,
        "changeLanguageContent": MessageLookupByLibrary.simpleMessage(
            "1. Go to the Settings page.\n2. Under \'Language Preferences,\' select your preferred language from the dropdown.\n3. The app will automatically switch to the selected language."),
        "changeLanguageTitle":
            MessageLookupByLibrary.simpleMessage("How to Change Language"),
        "changeThemeContent": MessageLookupByLibrary.simpleMessage(
            "1. Navigate to Settings.\n2. Under \'Theme,\' choose between light or dark mode."),
        "changeThemeTitle":
            MessageLookupByLibrary.simpleMessage("How to Change the Theme"),
        "colourScheme": MessageLookupByLibrary.simpleMessage("Colour Scheme"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteCategory":
            MessageLookupByLibrary.simpleMessage("Delete Category"),
        "deleteCategoryConfirmation": m1,
        "deletePhrase": MessageLookupByLibrary.simpleMessage("Delete Phrase"),
        "deletePhraseConfirmation": m2,
        "deletePhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. Navigate to the main phrase screen.\n2. Long press on the category or phrase you want to delete.\n3. A pop-up message will ask for confirmation. Select \'Delete\' to remove it."),
        "deletePhraseTitle": MessageLookupByLibrary.simpleMessage(
            "How to Delete a Phrase or Category"),
        "deleteUser": MessageLookupByLibrary.simpleMessage("Delete User"),
        "deleteUserConfirmation": m3,
        "deleteUserContent": MessageLookupByLibrary.simpleMessage(
            "1. Navigate to the Settings page.\n2. Select the user you wish to delete from the list.\n3. Tap the \'Delete\' button."),
        "deleteUserTitle":
            MessageLookupByLibrary.simpleMessage("How to Delete a User"),
        "enterYourName":
            MessageLookupByLibrary.simpleMessage("Enter your name"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "newCategory": MessageLookupByLibrary.simpleMessage("New Category"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("New Phrase"),
        "past": MessageLookupByLibrary.simpleMessage("Past"),
        "progressive": MessageLookupByLibrary.simpleMessage("Progressive"),
        "purposeContent": MessageLookupByLibrary.simpleMessage(
            "This app is designed to help users, especially those with communication challenges, construct sentences using predefined phrases. It also offers features like phrase suggestions, multiple languages, and text-to-speech to assist users in effective communication."),
        "purposeTitle":
            MessageLookupByLibrary.simpleMessage("What is this app for?"),
        "removeMessage":
            MessageLookupByLibrary.simpleMessage("Hold to remove all"),
        "selectUser": MessageLookupByLibrary.simpleMessage("Select User"),
        "setting": MessageLookupByLibrary.simpleMessage("Settings"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "usePhrasesContent": MessageLookupByLibrary.simpleMessage(
            "1. Navigate to the main phrase screen.\n2. Choose a category or start typing a phrase.\n3. The app will suggest phrases based on what you\'ve selected."),
        "usePhrasesTitle":
            MessageLookupByLibrary.simpleMessage("How to Use Phrases"),
        "useTTSContent": MessageLookupByLibrary.simpleMessage(
            "1. On the phrase screen, select a phrase or sentence.\n2. Tap the speaker icon to hear the phrase spoken aloud."),
        "useTTSTitle":
            MessageLookupByLibrary.simpleMessage("How to Use Text-to-Speech"),
        "userA": MessageLookupByLibrary.simpleMessage("User A"),
        "userB": MessageLookupByLibrary.simpleMessage("User B"),
        "userC": MessageLookupByLibrary.simpleMessage("User C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("User Guide"),
        "userGuideContent": MessageLookupByLibrary.simpleMessage(
            "User Guide Content Goes Here"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome!")
      };
}
