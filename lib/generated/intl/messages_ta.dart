// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ta locale. All the
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
  String get localeName => 'ta';

  static String m0(category) => "\'${category}\' வகை நீக்கப்பட்டது";

  static String m1(category) =>
      "\'${category}\' வகையையும் அதன் அனைத்து சொற்றொடர்களையும் நிச்சயமாக நீக்க விரும்புகிறீர்களா?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("வகையைச் சேர்"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("அணைப்பைச் சேர்"),
        "cancel": MessageLookupByLibrary.simpleMessage("ரத்து செய்"),
        "categoryDeleted": m0,
        "colourPaletteGenerator":
            MessageLookupByLibrary.simpleMessage("வண்ண தட்டு ஜெனரேட்டர்"),
        "colourScheme": MessageLookupByLibrary.simpleMessage("நிறத் திட்டம்"),
        "dark": MessageLookupByLibrary.simpleMessage("டார்க்"),
        "delete": MessageLookupByLibrary.simpleMessage("நீக்கு"),
        "deleteCategory": MessageLookupByLibrary.simpleMessage("வகையை நீக்கு"),
        "deleteCategoryConfirmation": m1,
        "home": MessageLookupByLibrary.simpleMessage("முகப்பு"),
        "language": MessageLookupByLibrary.simpleMessage("மொழி"),
        "light": MessageLookupByLibrary.simpleMessage("லைட்"),
        "newCategory":
            MessageLookupByLibrary.simpleMessage("புதிய வகையை உருவாக்கு"),
        "newPhrase":
            MessageLookupByLibrary.simpleMessage("புதிய அணைப்பை உருவாக்கு"),
        "removeMessage":
            MessageLookupByLibrary.simpleMessage("அனைத்தையும் நீக்க திடு"),
        "setting": MessageLookupByLibrary.simpleMessage("அமைப்புகள்"),
        "userA": MessageLookupByLibrary.simpleMessage("பயனர் A"),
        "userB": MessageLookupByLibrary.simpleMessage("பயனர் B"),
        "userC": MessageLookupByLibrary.simpleMessage("பயனர் C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("பயனர் வழிகாட்டி"),
        "userGuideContent": MessageLookupByLibrary.simpleMessage(
            "பயனர் வழிகாட்டி உள்ளடக்கம் இங்கு வருகிறது")
      };
}
